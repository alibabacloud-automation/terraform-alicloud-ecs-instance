variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-beijing"
}
variable "zone_id" {
  default = "cn-beijing-g"
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


// ECS Module
module "ecs_instance" {
  source  = "../../../modules/compute-optimized-type-with-fpga"
  profile = var.profile
  region  = var.region

  instance_type_family = "ecs.f3"
  //  Also can specify a instance type
  //  instance_type = "ecs.f3-c8f1.2xlarge"

  vswitch_id = alicloud_vswitch.default.id

  security_group_ids = [alicloud_security_group.default.id]

  associate_public_ip_address = true

  internet_max_bandwidth_out = 10

  //  Post-paid instances are out of stock, pre-paid instances must be specified for this type of instance
  //  instance_charge_type = "PrePaid"
}