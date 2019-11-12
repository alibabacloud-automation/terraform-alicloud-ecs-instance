// Output the IDs of the ECS instances created
output "this_instance_id" {
  value = module.ecs-instance.this_instance_id
}

output "this_instance_name" {
  value = module.ecs-instance.this_instance_name
}

output "this_instance_tags" {
  value = module.ecs-instance.this_instance_tags
}

output "this_availability_zone" {
  value = module.ecs-instance.this_availability_zone
}

# VSwitch  ID
output "this_vswitch_id" {
  value = module.ecs-instance.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  value = module.ecs-instance.this_security_group_ids
}

# Key pair outputs
output "this_key_name" {
  value = module.ecs-instance.this_key_name
}

# Ecs instance outputs
output "this_image_id" {
  value = module.ecs-instance.this_image_id
}

output "this_instance_type" {
  value = module.ecs-instance.this_instance_type
}

output "this_system_category" {
  value = module.ecs-instance.this_system_disk_category
}

output "this_system_size" {
  value = module.ecs-instance.this_system_disk_size
}

output "this_host_name" {
  value = module.ecs-instance.this_host_name
}

output "this_private_ip" {
  value = module.ecs-instance.this_private_ip
}

output "this_internet_charge_type" {
  value = module.ecs-instance.this_internet_charge_type
}

output "this_internet_max_bandwidth_out" {
  value = module.ecs-instance.this_internet_max_bandwidth_out
}

output "this_instance_charge_type" {
  value = module.ecs-instance.this_instance_charge_type
}

output "this_period" {
  value = module.ecs-instance.this_period
}

output "this_user_data" {
  value = module.ecs-instance.this_user_data
}

output "this_credit_specification" {
  value = module.ecs-instance.this_credit_specification
}

output "this_resource_group_id" {
  value = module.ecs-instance.this_resource_group_id
}

output "this_data_disks" {
  value = module.ecs-instance.this_data_disks
}

output "this_internet_max_bandwidth_in" {
  value = module.ecs-instance.this_internet_max_bandwidth_in
}

output "this_renewal_status" {
  value = module.ecs-instance.this_renewal_status
}

output "this_period_unit" {
  value = module.ecs-instance.this_period_unit
}

output "this_auto_renew_period" {
  value = module.ecs-instance.this_auto_renew_period
}


output "this_role_name" {
  value = module.ecs-instance.this_role_name
}

output "this_spot_strategy" {
  value = module.ecs-instance.this_spot_strategy
}

output "this_spot_price_limit" {
  value = module.ecs-instance.this_spot_price_limit
}

output "this_deletion_protection" {
  value = module.ecs-instance.this_deletion_protection
}

output "this_security_enhancement_strategy" {
  value = module.ecs-instance.this_security_enhancement_strategy
}

output "this_volume_tags" {
  value = module.ecs-instance.this_volume_tags
}
