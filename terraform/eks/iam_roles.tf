resource "aws_iam_role" "web-app-cluster" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach the AmazonEKSClusterPolicy managed policy
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.web-app-cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Attach the AmazonEKSWorkerNodePolicy managed policy
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.web-app-cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach the AmazonEKS_VPCResourceController policy
resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.web-app-cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_VPCResourceController"
}

# Optional: Attach custom policies for Kubernetes access (if needed)
resource "aws_iam_role_policy" "web-app-policy" {
  name = "eks-node-role-policy"
  role = aws_iam_role.web-app-cluster.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:ListUpdates",
          "eks:DescribeUpdate",
          "eks:DescribeNodegroup"
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
}