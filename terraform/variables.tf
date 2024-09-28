variable "subnets" {
  description = "Lista de IDs das sub-redes onde o EKS será criado"
  type        = list(string)
}

variable "region" {
  description = "Regiao que a infra será disponibilizada"
  type        = string
}
