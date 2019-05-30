// https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
// https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html

// https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "kubernetes_control_plane_security_group" {
  name = "${var.cluster_name}.control_plane"
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "${var.cluster_name}.control_plane"
    Cluster = "${var.cluster_name}"
    Project = "${var.project_name}"
    Owner = "${var.owner_name}"
    VPC = "${var.vpc_name}"
  }
}

// https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "control_plane_https_from_worker_node" {
  from_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.kubernetes_control_plane_security_group.id}"
  to_port = 443
  type = "ingress"
  source_security_group_id = "${aws_security_group.kubernetes_worker_node_security_group.id}"
}

// https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "control_plane_all_to_worker_node" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.kubernetes_control_plane_security_group.id}"
  to_port = 0
  type = "egress"
  source_security_group_id = "${aws_security_group.kubernetes_worker_node_security_group.id}"
}

// https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "control_plane_all_from_control_plane" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.kubernetes_control_plane_security_group.id}"
  to_port = 0
  type = "ingress"
  source_security_group_id = "${aws_security_group.kubernetes_control_plane_security_group.id}"
}

// https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "control_plane_all_to_control_plane" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.kubernetes_control_plane_security_group.id}"
  to_port = 0
  type = "egress"
  source_security_group_id = "${aws_security_group.kubernetes_control_plane_security_group.id}"
}
