# EKS Automation 
Complete automated script for EKS Deployment using Terraform with the Deployment of Ingress Controller , Metric Server and Cluster Autoscaler

# Features
* Contains a bash file in which terraform commands are written to build infrastructure and it also consistes of all the required helm charts.



# Inputs

|Name              |Description                                          |Type   |Default|
|------------------|-----------------------                              |-------|-------|
|vpc_name    |Name of your vpc                               |string |""     |
|vpc_cidr  |The IPv4 CIDR block for the VPC                    |string |""     |0.0.0.0/0
|vpc_azs          |A list of availability zones names                          |string |[]     |
|vpc_private_subnets    |private subnets inside the VPC              | |[]       |
|vpc_public_subnets          |private subnets inside the VPC |   |[]  |
|vpc_tags |Additional tags for the VPC	        |number |1      |
|eks_cluster_name    |Name of your cluster                               |string |""     |
|eks_cluster_version  | Kubernetes `<major>.<minor>` version to use for the EKS cluste       |string |null    |
|eks_managed_node_group_default_instance_type          |Instance types                          |string |""     |
|managed_nodes_min_capacity    |            |number |       |
|managed_nodes_max_capacity          |  |number   |  |
|managed_nodes_desired_capacitytags | |number |1      |
|managed_nodes_instance_type_list    |         |string |    |
|managed_nodes_capacity_type  |                                  |string |""     |
|managed_nodes_tags          | |string |""     |


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

