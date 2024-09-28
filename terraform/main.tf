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
    helm = {
      source = "hashicorp/helm"
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

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Ou outra configuração de kubeconfig
  }
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

resource "helm_release" "controle_pedidos" {
  name      = "controle-pedidos"
  chart     = "./kubernetes/controlepedidos-chart"
  namespace = "default"

  set {
    name  = "mercadoPagoIntegration.token"
    value = var.mercado_pago_token
  }

  set {
    name  = "mercadoPagoIntegration.urlWebhook"
    value = var.mercado_pago_webhook
  }

  set {
    name  = "userId"
    value = var.mercado_pago_user_id
  }

  set {
    name  = "externalPosId"
    value = var.mercado_pago_external_pos_id
  }

  depends_on = [
    aws_eks_node_group.controle_pedido_node_group
  ]
}

resource "null_resource" "validate_helm_release" {
  depends_on = [helm_release.controle_pedidos]

  provisioner "local-exec" {
    command = "kubectl get pods -n default -l app=controle-pedidos"
  }
}

output "controle_pedidos_status" {
  value = helm_release.controle_pedidos.status
}
