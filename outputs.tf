output "eks_cluster_id" {
  value = "${aws_eks_cluster.control_plane.id}"
}

output "eks_cluster_arn" {
  value = "${aws_eks_cluster.control_plane.arn}"
}
output "eks_cluster_certificate_authority" {
  value = "${aws_eks_cluster.control_plane.certificate_authority}"
}

output "eks_cluster_endpoint" {
  value = "${aws_eks_cluster.control_plane.endpoint}"
}

output "eks_cluster_platform_version" {
  value = "${aws_eks_cluster.control_plane.platform_version}"
}


output "eks_cluster_version" {
  value = "${aws_eks_cluster.control_plane.version}"
}


output "eks_cluster_vpc_config" {
  value = "${aws_eks_cluster.control_plane.vpc_config}"
}

output "aws_iam_role_control_plane_arn" {
  value = "${aws_iam_role.control_plane.arn}"
}
output "aws_iam_role_control_plane_create_date" {
  value = "${aws_iam_role.control_plane.create_date}"
}

output "aws_iam_role_control_plane_description" {
  value = "${aws_iam_role.control_plane.description}"
}

output "aws_iam_role_control_plane_id" {
  value = "${aws_iam_role.control_plane.id}"
}

output "aws_iam_role_control_plane_name" {
  value = "${aws_iam_role.control_plane.name}"
}

output "aws_iam_role_control_plane_unique_id" {
  value = "${aws_iam_role.control_plane.unique_id}"
}


output "aws_iam_role_worker_node_arn" {
  value = "${aws_iam_role.worker_node.arn}"
}
output "aws_iam_role_worker_node_create_date" {
  value = "${aws_iam_role.worker_node.create_date}"
}

output "aws_iam_role_worker_node_description" {
  value = "${aws_iam_role.worker_node.description}"
}

output "aws_iam_role_worker_node_id" {
  value = "${aws_iam_role.worker_node.id}"
}

output "aws_iam_role_worker_node_name" {
  value = "${aws_iam_role.worker_node.name}"
}

output "aws_iam_role_worker_node_unique_id" {
  value = "${aws_iam_role.worker_node.unique_id}"
}


output "kubeconfig_path" {
  value = "${local_file.kubeconfig.filename}"
}


output "security_group_control_plane_id" {
  value = "${aws_security_group.control_plane.id}"
}
output "security_group_control_plane_arn" {
  value = "${aws_security_group.control_plane.arn}"
}
output "security_group_control_plane_vpc_id" {
  value = "${aws_security_group.control_plane.vpc_id}"
}
output "security_group_control_plane_owner_id" {
  value = "${aws_security_group.control_plane.owner_id}"
}
output "security_group_control_plane_name" {
  value = "${aws_security_group.control_plane.name}"
}
output "security_group_control_plane_description" {
  value = "${aws_security_group.control_plane.description}"
}
output "security_group_control_plane_ingress" {
  value = "${aws_security_group.control_plane.ingress}"
}
output "security_group_control_plane_egress" {
  value = "${aws_security_group.control_plane.egress}"
}


output "security_group_worker_node_id" {
  value = "${aws_security_group.worker_node.id}"
}
output "security_group_worker_node_arn" {
  value = "${aws_security_group.worker_node.arn}"
}
output "security_group_worker_node_vpc_id" {
  value = "${aws_security_group.worker_node.vpc_id}"
}
output "security_group_worker_node_owner_id" {
  value = "${aws_security_group.worker_node.owner_id}"
}
output "security_group_worker_node_name" {
  value = "${aws_security_group.worker_node.name}"
}
output "security_group_worker_node_description" {
  value = "${aws_security_group.worker_node.description}"
}
output "security_group_worker_node_ingress" {
  value = "${aws_security_group.worker_node.ingress}"
}
output "security_group_worker_node_egress" {
  value = "${aws_security_group.worker_node.egress}"
}

