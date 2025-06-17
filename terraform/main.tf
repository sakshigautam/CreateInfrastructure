module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  subnets         = var.subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_size   = 1
      max_size       = 1
      min_size       = 0
      instance_types = ["t3.medium"]
    }
  }
}