locals {
  // This type of instance contains the following instance type families
  instance_type_families = ["ecs.ebmgn6i"]
}


data "alicloud_instance_types" "this" {
  instance_type_family = local.instance_type_families[var.instance_type_families_index]
}

// Security Group module for ECS Module
module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.vpc_id
}

// VPC module for ECS Module
module "vpc" {
  source        = "alibaba/vpc/alicloud"
  vpc_name      = "CreateByTerraform"
  vswitch_name  = "CreateByTerraform"
  vpc_cidr      = "172.16.0.0/12"
  vswitch_cidrs = ["172.16.0.0/24"]
  availability_zones = [data.alicloud_instance_types.this.instance_types.0.availability_zones.0]
}

module "ecs-instance" {
  source          = "alibaba/ecs-instance/alicloud"
  security_groups = [module.security_group.this_security_group_id]
  vswitch_id      = module.vpc.vswitch_ids.0
  instance_name   = "CreateByTerraform"
  // You can specify other elements in the instance type families list for this field
  //instance_type_family = local.instance_type_families[var.instance_type_families_index]
  instance_type = data.alicloud_instance_types.this.instance_types.0.id
}

variable "instance_type_families_index" {
  description = "Select the instance type family for creating instances by index"
  default = 0
}