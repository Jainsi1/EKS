module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.provision_vpc ? module.vpc[0].vpc_id : var.vpc_id
  subnet_ids               = var.provision_vpc ? module.vpc[0].private_subnets : var.private_subnet_ids
  control_plane_subnet_ids = var.provision_vpc ? module.vpc[0].public_subnets : var.public_subnet_ids

  eks_managed_node_group_defaults = {
    instance_types = var.eks_managed_node_group_default_instance_type
    iam_role_additional_policies = {
      additional1 = aws_iam_policy.cluster-autoscaler-additional.arn, 
      additional2 = var.ssm_policy_arn
    }
  }

  eks_managed_node_groups = {
    eks-dev-instance = {
      min_size     = var.managed_nodes_min_capacity
      max_size     = var.managed_nodes_max_capacity
      desired_size = var.managed_nodes_desired_capacity

      instance_types = var.managed_nodes_instance_type_list
      capacity_type  = var.managed_nodes_capacity_type
      labels = var.managed_nodes_tags
    }
  }
}