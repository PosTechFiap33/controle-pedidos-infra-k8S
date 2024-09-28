variable "subnets" {
  description = "Lista de IDs das sub-redes onde o EKS será criado"
  type        = list(string)
}
