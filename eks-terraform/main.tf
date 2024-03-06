module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

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

  vpc_id                   = var.vpc_id
  subnet_ids               = [var.subnet_id_1, var.subnet_id_2, var.subnet_id_3]
  control_plane_subnet_ids = [var.subnet_id_1, var.subnet_id_2, var.subnet_id_3]

  eks_managed_node_group_defaults = {
    instance_types = ["m4.xlarge", "m5.large", "m6g.large"]
  }

  eks_managed_node_groups = {
    eks_test = {
      min_size     = 1
      max_size     = 3
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    eks_test = {
      kubernetes_groups = []
      principal_arn     = var.principal_arn

      policy_associations = {
        eks_test = {
          policy_arn = var.policy_arn
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
    }
  }

  tags = {
    Environment = var.Environment
    Terraform   = var.Terraform
    project = var.project
    owner = var.owner
  }
}