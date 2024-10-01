variable "region" {
  default = "us-east-1"
}

variable "projectName" {
  default = "controle-pedido-cluster"
}

variable "labRole" {
  default = "arn:aws:iam::752307938219:role/LabRole"
}

variable "accessConfig" {
  default = "API_AND_CONFIG_MAP"
}

variable "nodeGroup" {
  default = "controle-pedidos-ng"
}

variable "instanceType" {
  default = "t3.micro"
}

variable "principalArn" {
  default = "arn:aws:iam::752307938219:role/voclabs"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}