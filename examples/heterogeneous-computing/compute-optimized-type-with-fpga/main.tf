variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}
variable "zone_id" {
  default = "cn-hangzhou-f"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

#############################################################
# Data sources to get VPC, vswitch and default security group details
#############################################################

data "alicloud_vpcs" "default" {
  is_default = true
}

resource "alicloud_security_group" "group" {
  name   = "test-group"
  vpc_id = alicloud_vpc.vpc.id
}

data "alicloud_vswitches" "default" {
  is_default = true
  zone_id    = var.zone_id
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

// If there is no default vswitch, create one.
resource "alicloud_vswitch" "default" {
  count             = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  availability_zone = var.zone_id
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/21"
}


// ECS Module
module "ecs_instance" {
  source  = "../../../modules/compute-optimized-type-with-fpga"
  profile = var.profile
  region  = var.region

  instance_type_family = "ecs.f1"
  //  Also can specify a instance type
  //  instance_type = "ecs.f1-c8f1.2xlarge"

  vswitch_id = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : concat(alicloud_vswitch.default.*.id, [""])[0]

  security_group_ids = [alicloud_security_group.group.id]

  associate_public_ip_address = true

  internet_max_bandwidth_out = 10

  //  Post-paid instances are out of stock, pre-paid instances must be specified for this type of instance
  //  instance_charge_type = "PrePaid"
}