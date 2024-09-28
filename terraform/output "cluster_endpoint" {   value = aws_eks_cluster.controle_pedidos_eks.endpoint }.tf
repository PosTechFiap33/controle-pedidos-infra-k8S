output "cluster_name" {
  value = aws_eks_cluster.controle_pedidos_eks.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.controle_pedidos_eks.endpoint
}
