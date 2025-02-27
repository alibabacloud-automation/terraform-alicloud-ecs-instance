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
module "ecs_instance" {
  source = "../../../modules/visualization-compute-optimized-type-with-gpu"

  instance_type_family = "ecs.vgn7i-vws"
  #  Also can specify a instance type
  #  instance_type = "ecs.vgn7i-vws-m24.7xlarge"

  system_disk_category = "cloud_essd"

  vswitch_id = alicloud_vswitch.default.id

  security_group_ids = [alicloud_security_group.default.id]

  associate_public_ip_address = true

  internet_max_bandwidth_out = 10
}