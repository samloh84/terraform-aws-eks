variable "control_plane_subnet_ids" {
  type = "list"
}
variable "control_plane_security_group_ids" {
  type = "list"
}
variable "cluster_name" {}

variable "vpc_id" {}

variable "project_name" {}
variable "vpc_name" {}

variable "owner_name" {}

variable "kubernetes_version" {
  default = "1.12"
}

variable "worker_node_instance_type" {
  default = "t3.micro"
}
variable "worker_node_volume_size" {}
variable "worker_node_key_name" {}
variable "worker_node_subnet_ids" {
  type = "list"
}
variable "worker_node_security_group_ids" {
  type = "list"
}

variable "worker_node_desired_capacity" {}
variable "worker_node_max_size" {}
variable "worker_node_min_size" {}
variable "worker_node_bootstrap_extra_args" {}
variable "worker_node_kubelet_extra_args" {}
variable "worker_node_pre_commands" {}
variable "worker_node_post_commands" {}

