terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "library-eks"
  cluster_version = "1.30"

  subnet_ids = ["subnet-0dc44180bd7bbb38c", "subnet-0d0f794c19c0a6fe6"]
  vpc_id     = "vpc-0167ed7c0da35e954"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  access_entries = {
    cli_user = {
      principal_arn = "arn:aws:iam::709107513396:user/cli-user"

      policy_associations = {
        admin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }

    root_user = {
      principal_arn = "arn:aws:iam::709107513396:root"

      policy_associations = {
        admin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }

  eks_managed_node_groups = {
    worker_nodes = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]

      iam_role_additional_policies = {
        ecr_read = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }
}
