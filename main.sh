#!/bin/bash
terraform init
terraform plan
terraform apply -auto-approve
aws eks update-kubeconfig --region `terraform output eks_cluster_arn | cut -d':' -f4` --name `terraform output eks_cluster_name | tr -d '"'`
export CLUSTER_NAME=`terraform output eks_cluster_name | tr -d '"'` && export AUTOSCALER_ROLE=`terraform output cluster-autosclaer-role-arn| tr -d '"'` && envsubst < cluster-autoscaler.yml > cluster-autoscaler-with-envs.yml
kubectl create namespace utilities || true
helm upgrade -i ingress-nginx ingress-nginx/ -n utilities 
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
helm upgrade -i sample-nginx-app sample-nginx-app/
helm upgrade -i sample-apache-app sample-apache-app/
