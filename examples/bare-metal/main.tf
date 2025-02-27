
provider "alicloud" {
  region = var.region
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
  security_group_name = "default"
  vpc_id              = alicloud_vpc.default.id
}

# ECS Module
module "bare_metal_cpu_ecs_instance" {
  source = "../../modules/bare-metal-cpu"

  instance_type_family = "ecs.ebmc6"
  #  Also can specify a instance type
  #  instance_type = "ecs.ebmhfg5.2xlarge"

  vswitch_id = alicloud_vswitch.default.id

  security_group_ids = [alicloud_security_group.default.id]

  associate_public_ip_address = true

  internet_max_bandwidth_out = 10

  #  Post-paid instances are out of stock, pre-paid instances must be specified for this type of instance
  #  instance_charge_type = "PrePaid"
}