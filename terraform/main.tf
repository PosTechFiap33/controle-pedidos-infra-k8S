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
  region = var.region
}

resource "aws_eks_cluster" "controle_pedidos_eks" {
  name     = "controle-pedidos-cluster"
  role_arn = "arn:aws:iam::752307938219:role/LabRole"

  vpc_config {
    subnet_ids = var.subnets
  }
}

resource "aws_eks_node_group" "controle_pedido_node_group" {
  cluster_name    = aws_eks_cluster.controle_pedidos_eks.name
  node_group_name = "controle-pedido-node-group"
  node_role_arn   = "arn:aws:iam::752307938219:role/LabRole"

  subnet_ids = var.subnets

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t2.micro"]

  depends_on = [
    aws_eks_cluster.controle_pedidos_eks
  ]
}
