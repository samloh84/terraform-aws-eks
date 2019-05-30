

data "template_file" "node_config_map" {
  template = "${file("${path.module}/aws-auth-cm.yml")}"
  vars {
    node_role_arn = "${aws_iam_role.worker_node.arn}"
  }
}


resource "local_file" "aws-auth-cm" {
  content = "${data.template_file.node_config_map.rendered}"
  filename = "${path.cwd}/${var.cluster_name}_aws-auth-cm.yml"
}

data "template_file" "kubeconfig" {
  template = "${file("${path.module}/kubeconfig.yml")}"
  vars {
    cluster_name = "${var.cluster_name}"
    cluster_auth_base64 = "${aws_eks_cluster.control_plane.certificate_authority.0.data}"
    endpoint = "${aws_eks_cluster.control_plane.endpoint}"
  }
}


resource "local_file" "kubeconfig" {
  content = "${data.template_file.kubeconfig.rendered}"
  filename = "${path.cwd}/kubeconfig.yml"
}

resource "null_resource" "run_kubectl" {
  provisioner "local-exec" {
    interpreter = [
      "/bin/bash",
      "-c"]
    command = "kubectl apply -f ${local_file.aws-auth-cm.filename}"
    environment {
      KUBECONFIG = "${local_file.kubeconfig.filename}"
    }
  }

  triggers {
    eks_cluster_id = "${aws_eks_cluster.control_plane.id}"
  }
}


