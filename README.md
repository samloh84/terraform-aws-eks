# Terraform AWS EKS

Terraform module for creating an EKS Cluster on AWS 

## Usage

```hcl-terraform
module "eks" {
  source = "git::https://github.com/samloh84/terraform-aws-eks.git"
  cluster_name = "eks"
  control_plane_subnet_ids = "${module.vpc-simple.subnet_application_tier_ids}"
  owner_name = "Samuel"
  project_name = "eks"
  vpc_id = "${module.vpc-simple.vpc_id}"
  vpc_name = "vpc-simple"
  worker_node_bootstrap_extra_args = ""
  worker_node_desired_capacity = "1"
  worker_node_instance_type = "t3.micro"
  worker_node_key_name = "govtech-iacwg"
  worker_node_kubelet_extra_args = ""
  worker_node_max_size = "1"
  worker_node_min_size = "1"
  worker_node_post_commands = ""
  worker_node_pre_commands = ""
  worker_node_subnet_ids = "${module.vpc-simple.subnet_application_tier_ids}"
  worker_node_volume_size = "200"
  control_plane_security_group_ids = ["${module.vpc-simple.security_group_application_tier_id}"]
  worker_node_security_group_ids = ["${module.vpc-simple.security_group_application_tier_id}"]
}
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
