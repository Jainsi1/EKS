# EKS Deployment

# Architecture


# Features
* Contains a bash file in which terraform commands are written to build infrastructure and it also installs all the required helm charts.
* For doing this complete setup you have to just run the bash file by giving it permission to execute as:

  1. chmod +x main.sh
  2. ./main.sh

# HelmCharts 
 Helm charts used here are as:

1. ## Nginx Ingress Controller:
NGINX Ingress Controller provides a robust feature set to secure, strengthen, and scale your containerized apps.
NGINX Ingress Controller works with both NGINX and NGINX Plus and supports the standard Ingress features - content-based routing and TLS/SSL termination. NGINX Ingress Controller supports the VirtualServer and VirtualServerRoute resources. They enable use cases not supported with the Ingress resource, such as traffic splitting and advanced content-based routing.
https://github.com/kubernetes/ingress-nginx

2. ## Cluster Autoscaler:
Kubernetes Cluster Autoscaler automatically adjusts the number of nodes in your cluster when pods fail or are rescheduled onto other nodes. The Cluster Autoscaler is typically installed as a Deployment in your cluster.
Cluster autoscaler scales down only the nodes that can be safely removed.
https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler

3. ## Secrets Store CSI Driver
The Secrets Store CSI Driver is used with AWS Secrets Manager to securely store and retrieve secrets within a Kubernetes cluster. It provides a seamless integration with AWS Secret Manager, allowing users to leverage its features for managing sensitive information such as API keys, database credentials, and certificates in their Kubernetes applications. This ensures a more secure and scalable approach to secret management in AWS environments.
https://secrets-store-csi-driver.sigs.k8s.io/

4. ## Secrets Store CSI Driver Provider AWS
The Secrets Store CSI Driver Provider AWS is used with the Secrets Store CSI Driver to enable seamless integration with AWS services, specifically AWS Secrets Manager. It acts as a bridge between the Secrets Store CSI Driver and AWS Secrets Manager, allowing Kubernetes applications to securely access and manage secrets stored in AWS Secrets Manager.
https://github.com/aws/secrets-store-csi-driver-provider-aws


# Inputs

|Name              |Description                                          |Type   |Default|
|------------------|-----------------------                              |-------|-------|
|vpc_name    |Name of your vpc                               |string |""     |
|vpc_cidr  |The IPv4 CIDR block for the VPC                    |string |0.0.0.0/0|
|vpc_azs          |A list of availability zones names                          |list(string) |[ ]     |
|vpc_private_subnets    |private subnets inside the VPC              |list(string) |[ ]       |
|vpc_public_subnets          |private subnets inside the VPC | list(string)  |[ ]  |
|vpc_tags |Additional tags for the VPC	        |map(string) |{ }     |
|eks_cluster_name    |Name of your cluster                               |string |""     |
|eks_cluster_version  | Kubernetes `<major>.<minor>` version to use for the EKS cluste       |string |null    |
|eks_managed_node_group_default_instance_type          |Instance types                          |string |""     |
|managed_nodes_min_capacity    |minimum  number of  pods running        |number |  1     |
|managed_nodes_max_capacity          |maximum number of  pods running |number   |  |
|managed_nodes_desired_capacity | desired size of pod which we want always|number |     |
|managed_nodes_instance_type_list    |    instance types      | list(string)|[ ]    |
|managed_nodes_capacity_type  | Capacity type of ec2          |string |On Demand     |
|managed_nodes_tags          |Aditional tags for the node |map(string) |{ }|


# Outputs

|Name              |Description                        |                                    
|------------------|-----------------------            |                
|eks_cluster_name    |Name that identifies the cluster |                   
|eks_cluster_arn       |ARN that identifies the cluster    |   
|eks_oidc|The URL on the EKS cluster for the OpenID Connect identity provider|
|eks_oidc_provider|The OpenID Connect identity provider|
|oidc_provider_arn|The ARN of the OIDC Provider|
|cluster-autosclaer-role-arn  |ARN of the cluster-autoscaler role|
|cluster-version|version of cluster|
