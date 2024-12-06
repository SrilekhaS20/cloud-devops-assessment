resource "aws_eks_cluster" "web-app-cluster" {
  name     = "web-app-cluster"
  role_arn = aws_iam_role.web-app-cluster.arn

  vpc_config {
    subnet_ids = var.subnet_ids.id
  }
}