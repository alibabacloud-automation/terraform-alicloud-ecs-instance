# Output the IDs of the ECS instances created
output "this_disk_attachment_disk_id" {
  description = "The disk ID"
  value       = alicloud_disk_attachment.this_ecs[*].disk_id
}

output "this_disk_attachment_instance_id" {
  description = "The instance ID"
  value       = alicloud_disk_attachment.this_ecs[*].instance_id
}

output "this_instance_ids" {
  description = "The instance ID"
  value       = module.ecs.this_instance_id
}

output "this_instance_names" {
  description = "The instance name"
  value       = module.ecs.this_instance_name
}

# VSwitch  ID
output "this_vswitch_ids" {
  description = "The vswitch ID"
  value       = module.ecs.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  description = "The security group ID"
  value       = module.ecs.this_security_group_ids
}

output "this_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = module.ecs.this_private_ip
}

output "this_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = module.ecs.this_public_ip
}

output "this_tags" {
  description = "The tags of the ECS instance"
  value       = module.ecs.this_instance_tags
}