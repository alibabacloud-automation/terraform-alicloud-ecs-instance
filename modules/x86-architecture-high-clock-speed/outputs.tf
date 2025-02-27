# Output the IDs of the ECS instances created
output "this_instance_id" {
  description = "The instance ids."
  value       = module.ecs-instance.this_instance_id
}

output "this_instance_name" {
  description = "The instance names."
  value       = module.ecs-instance.this_instance_name
}

output "this_instance_type" {
  description = "The type of the instance."
  value       = module.ecs-instance.this_instance_type
}

output "this_image_id" {
  description = "The image ID used by the instance."
  value       = module.ecs-instance.this_image_id
}

output "this_instance_tags" {
  description = "The tags for the instance."
  value       = module.ecs-instance.this_instance_tags
}

output "this_private_ip" {
  description = "The private ip of the instance."
  value       = module.ecs-instance.this_private_ip
}

output "this_public_ip" {
  description = "The public ip of the instance."
  value       = module.ecs-instance.this_public_ip
}

output "this_availability_zone" {
  description = "The zone id of the instance."
  value       = module.ecs-instance.this_availability_zone
}

output "this_system_disk_auto_snapshot_policy_id" {
  description = "The system disk auto snapshot policy id of the instance."
  value       = module.ecs-instance.this_system_disk_auto_snapshot_policy_id
}

# VSwitch  ID
output "this_vswitch_id" {
  description = "The vswitch id in which the instance."
  value       = module.ecs-instance.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  description = "The security group ids in which the instance."
  value       = module.ecs-instance.this_security_group_ids
}

