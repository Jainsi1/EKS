module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  count = var.provision_vpc ? 1 : 0
  name = var.provision_vpc ? var.vpc_name : null
  cidr = var.provision_vpc ? var.vpc_cidr : null

  azs             = var.provision_vpc ? var.vpc_azs : null
  private_subnets = var.provision_vpc ? var.vpc_private_subnets : null
  public_subnets  = var.provision_vpc ? var.vpc_public_subnets : null

  enable_nat_gateway = var.provision_vpc ? true : false
  single_nat_gateway  = var.provision_vpc ? true : false

  tags = var.provision_vpc ? var.vpc_tags : null
}