variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}
variable "zone_id" {
  default = "cn-hangzhou-h"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

#############################################################
# create VPC, vswitch and security group
#############################################################

resource "alicloud_vpc" "default" {
  vpc_name   = "tf_module"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = "172.16.0.0/21"
  zone_id    = var.zone_id
}

resource "alicloud_security_group" "default" {
  name   = "default"
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ecs_hpc_cluster" "default" {
  name        = "tf_module"
  description = "For Terraform Test"
}

// ECS Module
module "ecs_instance" {
  source  = "../../../modules/super-computing-cluster-cpu"
  profile = var.profile
  region  = var.region

  instance_type_family = "ecs.scch5s"
  //  Also can specify a instance type
  # instance_type = "ecs.scch5s.16xlarge"

  image_name_regex = "^centos_7_05_64*"

  vswitch_id = alicloud_vswitch.default.id

  security_group_ids = [alicloud_security_group.default.id]

  associate_public_ip_address = true

  internet_max_bandwidth_out = 10

  hpc_cluster_id = alicloud_ecs_hpc_cluster.default.id

  //  Post-paid instances are out of stock, pre-paid instances must be specified for this type of instance
  //  instance_charge_type = "PrePaid"
}