# Output the IDs of the ECS instances created
output "this_instance_id" {
  description = "The ID of the ECS instances."
  value       = module.ecs_instance.this_instance_id
}

output "this_instance_name" {
  description = "The name of the ECS instances."
  value       = module.ecs_instance.this_instance_name
}

output "this_instance_type" {
  description = "The type of the ECS instances."
  value       = module.ecs_instance.this_instance_type
}

output "this_image_id" {
  description = "The image ID of the ECS instances."
  value       = module.ecs_instance.this_image_id
}

output "this_instance_tags" {
  description = "The tags of the ECS instances."
  value       = module.ecs_instance.this_instance_tags
}

output "this_private_ip" {
  description = "The private IP address of the ECS instances."
  value       = module.ecs_instance.this_private_ip
}

output "this_public_ip" {
  description = "The public IP address of the ECS instances."
  value       = module.ecs_instance.this_public_ip
}

output "this_availability_zone" {
  description = "The availability zone of the ECS instances."
  value       = module.ecs_instance.this_availability_zone
}

# VSwitch  ID
output "this_vswitch_id" {
  description = "The ID of the VSwitch."
  value       = module.ecs_instance.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  description = "The IDs of the security groups."
  value       = module.ecs_instance.this_security_group_ids
}