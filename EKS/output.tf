output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "oidc_provider" {
  value = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}