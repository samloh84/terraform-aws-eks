// https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html

// https://www.terraform.io/docs/providers/aws/d/aws_ami.html

data "aws_ami" "eks_optimized_ami" {
  filter {
    name = "name"
    values = [
      "amazon-eks-node-${var.kubernetes_version}-v????????"]
  }
  most_recent = true
  owners = [
    "602401143452"]
}


data "template_file" "user_data_worker_node" {
  template = "${file("${path.module}/user_data_worker_node.yml")}"
  vars = {
    cluster_name = "${var.cluster_name}"
    cluster_auth_base64 = "${aws_eks_cluster.control_plane.certificate_authority.0.data}"
    endpoint = "${aws_eks_cluster.control_plane.endpoint}"
    bootstrap_extra_args = "${var.worker_node_bootstrap_extra_args}"
    kubelet_extra_args = "${var.worker_node_kubelet_extra_args}"
    node_pre = "${var.worker_node_pre_commands}"
    node_post = "${var.worker_node_post_commands}"
  }
}

// https://www.terraform.io/docs/providers/aws/r/launch_template.html
resource "aws_launch_template" "worker_node" {
  name_prefix = "${var.cluster_name}_node"
  image_id = "${data.aws_ami.eks_optimized_ami.id}"
  instance_type = "${var.worker_node_instance_type}"
  vpc_security_group_ids = "${flatten([aws_security_group.kubernetes_worker_node_security_group.id, var.worker_node_security_group_ids])}"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = "${var.worker_node_volume_size}"
      delete_on_termination = true
    }
  }

  key_name = "${var.worker_node_key_name}"

  iam_instance_profile {
    arn = "${aws_iam_instance_profile.worker_node.arn}"
  }

  tag_specifications {
    resource_type = "instance"
    tags = "${merge(
    map("Name", "${var.cluster_name}.node"),
    map("kubernetes.io/cluster/${var.cluster_name}", "owned"),
    map("Project", "${var.project_name}"),
    map("Owner", "${var.owner_name}")
    )}"

  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "${var.cluster_name}.worker_node"
      Project = "${var.project_name}"
      Owner = "${var.owner_name}"
    }
  }

  tags = {
    Name = "${var.cluster_name}.worker_node"
    Project = "${var.project_name}"
    Owner = "${var.owner_name}"
  }

  user_data = "${base64encode(data.template_file.user_data_worker_node.rendered)}"
}

// https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "worker_node" {
  vpc_zone_identifier = "${flatten([var.worker_node_subnet_ids])}"
  desired_capacity = "${var.worker_node_desired_capacity}"
  max_size = "${var.worker_node_max_size}"
  min_size = "${var.worker_node_min_size}"

  launch_template {
    id = "${aws_launch_template.worker_node.id}"
    version = "$Latest"
  }
}
