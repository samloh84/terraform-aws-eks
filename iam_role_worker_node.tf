// https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "worker_node" {
  name = "eks.${var.cluster_name}.worker_node"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "${var.cluster_name}.worker_node"
    Cluster = var.cluster_name
    Project = var.project_name
    Owner = var.owner_name
  }
}

// https://www.terraform.io/docs/providers/aws/r/iam_role_attachment.html
resource "aws_iam_role_policy_attachment" "worker_node_eks_worker_node_policy" {
  role = aws_iam_role.worker_node.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

// https://www.terraform.io/docs/providers/aws/r/iam_role_attachment.html
resource "aws_iam_role_policy_attachment" "worker_node_eks_cni_policy" {
  role = aws_iam_role.worker_node.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

// https://www.terraform.io/docs/providers/aws/r/iam_role_attachment.html
resource "aws_iam_role_policy_attachment" "worker_node_ecr_policy" {
  role = aws_iam_role.worker_node.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

// https://www.terraform.io/docs/providers/aws/r/iam_policy.html

resource "aws_iam_policy" "autoscaling" {

  name = "${var.cluster_name}_autoscaling_policy"
  path = "/"
  description = "Policy to allow autoscaling by Kubernetes"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "autoscaling_attachment" {
  policy_arn = aws_iam_policy.autoscaling.arn
  role = aws_iam_role.worker_node.id
}

// https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html
resource "aws_iam_instance_profile" "worker_node" {
  name = "${var.cluster_name}.iam_instance_profile.node"
  role = aws_iam_role.worker_node.id
}

