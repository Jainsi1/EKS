#!/bin/bash
set -e
NEWRELIC_LICENSEKEY=                 #Put Your Newrelic LicenseKeyHere
NEWRELIC_CLUSTERNAME=                          #Put Cluster Name here
########
#example
# NEWRELIC_LICENSEKEY=bWFudGhhbnZpcnR1ZWNsb3Vk
# NEWRELIC_CLUSTERNAME=ExampleCluster
########
terraform init
terraform plan
terraform apply -auto-approve
aws eks update-kubeconfig --region `terraform output eks_cluster_arn | cut -d':' -f4` --name `terraform output eks_cluster_name | tr -d '"'`
export CLUSTER_NAME=`terraform output eks_cluster_name | tr -d '"'` && export AUTOSCALER_ROLE=`terraform output cluster-autosclaer-role-arn| tr -d '"'` && envsubst < cluster-autoscaler.yml > cluster-autoscaler-with-envs.yml
kubectl create namespace utilities || true
helm upgrade -i ingress-nginx ingress-nginx/ -n utilities 
helm upgrade -i metrics-server metrics-server/ -n utilities 
helm upgrade -i secrets-store-csi-driver secrets-store-csi-driver/ -n kube-system
helm upgrade -i secrets-store-csi-driver-provider-aws secrets-store-csi-driver-provider-aws/ -n kube-system
kubectl apply -f cluster-autoscaler-with-envs.yml
kubectl patch deployment cluster-autoscaler \
  -n kube-system \
  -p '{"spec":{"template":{"metadata":{"annotations":{"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"}}}}}'
kubectl set image deployment cluster-autoscaler \
  -n kube-system \
  cluster-autoscaler=registry.k8s.io/autoscaling/cluster-autoscaler:v1.25.0
export SECRET_MANAGER_ROLE=`terraform output secret-manager-role-arn| tr -d '"'` && envsubst < sample-nginx-app/values-template.yaml > sample-nginx-app/values.yaml
helm upgrade -i reloader reloader-kubernetes -n utilities
helm upgrade -i sample-nginx-app sample-nginx-app/
#NewRelic
if [ -n "$NEWRELIC_LICENSEKEY" ] && [ -n "$NEWRELIC_CLUSTERNAME" ]; then
  function ver { printf "%03d%03d" $(echo "$1" | tr '.' ' '); } && \
  K8S_VERSION=$(kubectl version --short 2>&1 | grep 'Server Version' | awk -F' v' '{ print $2; }' | awk -F. '{ print $1"."$2; }') && \
  if [[ $(ver $K8S_VERSION) -lt $(ver "1.25") ]]; then KSM_IMAGE_VERSION="v2.6.0"; else KSM_IMAGE_VERSION="v2.7.0"; fi && \
  helm repo add newrelic https://helm-charts.newrelic.com && helm repo update && \
  kubectl create namespace newrelic ; helm upgrade --install newrelic-bundle newrelic/nri-bundle \
  --set global.licenseKey=$NEWRELIC_LICENSEKEY \
  --set global.cluster=$NEWRELIC_CLUSTERNAME \
  --namespace=newrelic \
  --set newrelic-infrastructure.privileged=false \
  --set global.lowDataMode=false \
  --set kube-state-metrics.image.tag=${KSM_IMAGE_VERSION} \
  --set kube-state-metrics.enabled=true \
  --set kubeEvents.enabled=true \
  --set logging.enabled=true \
  --set newrelic-logging.lowDataMode=false 