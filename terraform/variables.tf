variable "subnets" {
  description = "Lista de IDs das sub-redes onde o EKS será criado"
  type        = list(string)
}

variable "region" {
  description = "Regiao que a infra será disponibilizada"
  type        = string
}

variable "mercado_pago_token" {
  type        = string
  description = "Token for Mercado Pago"
}

variable "mercado_pago_webhook" {
  type        = string
  description = "Webhook URL for Mercado Pago"
}

variable "mercado_pago_user_id" {
  type        = string
  description = "User ID for Mercado Pago"
}

variable "mercado_pago_external_pos_id" {
  type        = string
  description = "External POS ID for Mercado Pago"
}
