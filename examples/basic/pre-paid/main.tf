// ECS Disk Resource for Module
resource "alicloud_disk" "disk" {
  availability_zone = module.ecs-instance.this_availability_zone
  name              = "CreateByTerraform"
  category          = "cloud_efficiency"
  size              = "70"
}

// Attach ECS disks to instances for Module
resource "alicloud_disk_attachment" "disk_attach" {
  disk_id     = alicloud_disk.disk.id
  instance_id = module.ecs-instance.this_instance_id[0]
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
}

module "ecs-instance" {
  source          = "../../.."
  security_groups = [module.security_group.this_security_group_id]
  vswitch_id      = module.vpc.vswitch_ids.0
  instance_name   = "CreateByTerraform"
  instance_charge_type = "PrePaid"
  prepaid_settings = {
    "period"             = "1"
    "period_unit"        = "Month"
    "renewal_status"     = "Normal"
    "auto_renew_period"  = "1"
    "include_data_disks" = "true"
  }
  force_delete = true
}