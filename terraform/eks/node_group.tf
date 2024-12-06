resource "aws_eks_node_group" "web-app-ng" {
  cluster_name    = aws_eks_cluster.web-app-cluster.name
  node_role_arn   = aws_iam_role.web-app-cluster.arn
  subnet_ids      = var.subnet_ids.id
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}