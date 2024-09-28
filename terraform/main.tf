# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
# Fiap Pos tech

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "PosTechFiap33"

    workspaces {
      name = "ControlePedido"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "eks_subnet" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_eks_cluster" "controle_pedidos_eks" {
  name     = "controle-pedidos-cluster"
  role_arn = "arn:aws:iam::752307938219:role/LabRole"
  #role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet.id]
  }
}

# resource "aws_iam_role" "eks_role" {
#   name = "eks-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
#   role       = aws_iam_role.eks_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

resource "aws_eks_node_group" "controle_pedido_node_group" {
  cluster_name    = aws_eks_cluster.controle_pedidos_eks.name
  node_group_name = "controle-pedido-node-group"
  node_role_arn   = "arn:aws:iam::752307938219:role/LabRole"
# node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.eks_subnet.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

# resource "aws_iam_role" "eks_node_role" {
#   name = "eks-node-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "node_policy_attachment" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

# resource "aws_iam_role_policy_attachment" "cni_policy_attachment" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }