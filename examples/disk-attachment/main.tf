variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}

variable "instances_number" {
  default = 1
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "alicloud_vpcs" "default" {
  is_default = true
}

data "alicloud_vswitches" "all" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*_64"
}

// retrieve 1c2g instance type
data "alicloud_instance_types" "normal" {
  availability_zone = data.alicloud_vswitches.all.vswitches.0.zone_id
  cpu_core_count    = 1
  memory_size       = 2
}

// Security Group module for ECS Module
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  region  = var.region
  vpc_id  = data.alicloud_vpcs.default.ids.0
  version = "~> 2.0"
}

module "ecs" {
  source = "../.."
  region = var.region

  number_of_instances = 1

  name                        = "example-with-disks"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

resource "alicloud_disk_attachment" "this_ecs" {
  count = var.instances_number

  disk_id     = alicloud_disk.this[count.index].id
  instance_id = module.ecs.this_instance_id[count.index]
}

resource "alicloud_disk" "this" {
  count = var.instances_number

  availability_zone = module.ecs.this_availability_zone[count.index]
  size              = 20
}