variable "region" {
  default = "cn-hangzhou"
}
variable "zone_id" {
  default = "cn-hangzhou-h"
}

provider "alicloud" {
  region = var.region
}

#############################################################
# Data sources to get VPC, vswitch and default security group details
#############################################################

data "alicloud_vpcs" "default" {
  is_default = true
}

data "alicloud_security_groups" "default" {
  name_regex = "default"
  vpc_id     = data.alicloud_vpcs.default.ids.0
}

data "alicloud_vswitches" "default" {
  is_default = true
  zone_id    = var.zone_id
}

// If there is no default vswitch, create one.
resource "alicloud_vswitch" "default" {
  count             = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  availability_zone = var.zone_id
  vpc_id            = data.alicloud_vpcs.default.ids.0
  cidr_block        = cidrsubnet(data.alicloud_vpcs.default.vpcs.0.cidr_block, 4, 2)
}


// ECS Module
module "ecs_instance" {
  source = "../../../modules/compute-optimized-type-with-gpu"

  region = var.region

  instance_type_family = "ecs.gn6v"
  //  Also can specify a instance type
  //  instance_type = "ecs.gn6v-c8g1.2xlarge"

  vswitch_id = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : concat(alicloud_vswitch.default.*.id, [""])[0]

  security_group_ids = data.alicloud_security_groups.default.ids

  associate_public_ip_address = true

  internet_max_bandwidth_out = 10

  //  Post-paid instances are out of stock, pre-paid instances must be specified for this type of instance
  //  instance_charge_type = "PrePaid"
}