# EKS Automation 

<h1 align="center"> Virtuecloud </h1> <br>
<p align="center">
  <a href="https://virtuecloud.io/">
    <img alt="Virtuecloud" title="Virtuecloud" src="https://virtuecloud.io/assets/images/VitueCloud_Logo.png" width="450">
  </a>
</p>

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [HelmCharts](#helmCharts)
- [Inputs](#Inputs)
- [Outputs](#Outputs)

# Introduction

Complete automated script for EKS Deployment using Terraform with the Deployment of Ingress Controller , Metric Server and Cluster Autoscaler

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

2. ## Cluster Autoscaler:
Kubernetes Cluster Autoscaler automatically adjusts the number of nodes in your cluster when pods fail or are rescheduled onto other nodes. The Cluster Autoscaler is typically installed as a Deployment in your cluster.
Cluster autoscaler scales down only the nodes that can be safely removed.

3. ## Metric Server:
The Kubernetes Metrics Server collects resource metrics from the kubelet running on each worker node and exposes them in the Kubernetes API server through the Kubernetes Metrics API.



# Inputs

|Name              |Description                                          |Type   |Default|
|------------------|-----------------------                              |-------|-------|
|vpc_name    |Name of your vpc                               |string |""     |
|vpc_cidr  |The IPv4 CIDR block for the VPC                    |string |0.0.0.0/0|
|vpc_azs          |A list of availability zones names                          |list(strings) |[ ]     |
|vpc_private_subnets    |private subnets inside the VPC              |list(strings) |[ ]       |
|vpc_public_subnets          |private subnets inside the VPC | list(strings)  |[ ]  |
|vpc_tags |Additional tags for the VPC	        |map(strings) |{ }     |
|eks_cluster_name    |Name of your cluster                               |string |""     |
|eks_cluster_version  | Kubernetes `<major>.<minor>` version to use for the EKS cluste       |string |null    |
|eks_managed_node_group_default_instance_type          |Instance types                          |string |""     |
|managed_nodes_min_capacity    |minimum  number of  pods running        |number |  1     |
|managed_nodes_max_capacity          |maximum number of  pods running |number   |  |
|managed_nodes_desired_capacity | desired size of pod which we want always|number |     |
|managed_nodes_instance_type_list    |    instance types      | list|[ ]    |
|managed_nodes_capacity_type  | Capacity type of ec2          |string |On Demand     |
|managed_nodes_tags          |Aditional tags for the node |map(strings) |{ }|


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

