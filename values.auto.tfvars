vpc_name="dev-vpc"
vpc_cidr="10.2.0.0/16"
vpc_azs=["ap-south-1a", "ap-south-1b", "ap-south-1c"]
vpc_private_subnets=["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
vpc_public_subnets=["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"]
vpc_tags={
    Terraform = "true"
    Environment = "dev"
  }
eks_cluster_name="eks-dev-cluster"
eks_cluster_version="1.26"
eks_managed_node_group_default_instance_type=["t3.medium"]
managed_nodes_min_capacity=1
managed_nodes_max_capacity=10
managed_nodes_desired_capacity=1
managed_nodes_instance_type_list=["t3.medium"]
managed_nodes_capacity_type="ON_DEMAND"
managed_nodes_tags={
        Environment = "dev"
      }
efs_name = "test"
encryption = false
ssm_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"