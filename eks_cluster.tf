// https://www.terraform.io/docs/providers/aws/r/eks_cluster.html
resource "aws_eks_cluster" "control_plane" {

  name = var.cluster_name
  role_arn = aws_iam_role.control_plane.arn

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
  vpc_config {
    subnet_ids = var.control_plane_subnet_ids
    security_group_ids = flatten([
      aws_security_group.control_plane.id,
      var.control_plane_security_group_ids])

    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [
    "aws_iam_role_policy_attachment.control_plane_eks_cluster_policy",
    "aws_iam_role_policy_attachment.control_plane_eks_service_policy"]

  timeouts {
    create = "1h"
    delete = "1h"
    update = "1h"
  }
}
