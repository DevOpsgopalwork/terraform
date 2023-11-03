# #############################
#  resource "aws_eks_addon" "coredns" {
#   cluster_name = "eks-cluster-01"
#   addon_name   =  "coredns" 
#   # addon_version = "v1.9.3-eksbuild.7"
#   # resolve_conflicts_on_update = "PRESERVE"
# }

# ####################
#  resource "aws_eks_addon" "kube-proxy" {
#   cluster_name = "eks-cluster-01"
#   addon_name   = "kube-proxy"
#   # addon_version = "v1.26.9-eksbuild.2"
#   # resolve_conflicts_on_update = "PRESERVE"
# }
# #################
#  resource "aws_eks_addon" "vpc-cni" {
#   cluster_name = "eks-cluster-01"
#   addon_name   = "vpc-cni"
#   # addon_version  = "v1.15.1-eksbuild.1"
#   # resolve_conflicts_on_update = "PRESERVE"
# }

# ######################
 resource "aws_eks_addon" "ebs-csi" {
  cluster_name = "eks-cluster-01"
  addon_name   = "aws-ebs-csi-driver"
}