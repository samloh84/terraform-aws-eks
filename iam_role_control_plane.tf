// https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "control_plane" {
  name = "eks.${var.cluster_name}.control_plane"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "${var.cluster_name}.control_plane"
    Cluster = "${var.cluster_name}"
    Project = "${var.project_name}"
    Owner = "${var.owner_name}"
  }
}

// https://www.terraform.io/docs/providers/aws/r/iam_role_attachment.html
resource "aws_iam_role_policy_attachment" "control_plane_eks_cluster_policy" {
  role = "${aws_iam_role.control_plane.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
// https://www.terraform.io/docs/providers/aws/r/iam_role_attachment.html
resource "aws_iam_role_policy_attachment" "control_plane_eks_service_policy" {
  role = "${aws_iam_role.control_plane.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

