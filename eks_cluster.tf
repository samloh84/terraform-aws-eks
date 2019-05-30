// https://www.terraform.io/docs/providers/aws/r/eks_cluster.html
resource "aws_eks_cluster" "control_plane" {

  name = "${var.cluster_name}"
  role_arn = "${aws_iam_role.control_plane.arn}"

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator"
  ]
  vpc_config {
    subnet_ids = "${var.control_plane_subnet_ids}"
    security_group_ids = "${aws_security_group.kubernetes_control_plane_security_group.id}"

    endpoint_private_access = true
    endpoint_public_access = true
  }
}
