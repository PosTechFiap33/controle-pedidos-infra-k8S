terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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