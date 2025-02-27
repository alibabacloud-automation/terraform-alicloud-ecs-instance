# Output the IDs of the ECS instances created
output "this_instance_id" {
  description = "The instance id of the ECS instance."
  value       = module.ecs.this_instance_id
}

output "this_instance_name" {
  description = "The instance name of the ECS instance."
  value       = module.ecs.this_instance_name
}

# VSwitch  ID
output "this_vswitch_id" {
  description = "The vswitch id of the ECS instance."
  value       = module.ecs.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  description = "The security group ids of the ECS instance."
  value       = module.ecs.this_security_group_ids
}

output "this_private_ip" {
  description = "The instance private ip"
  value       = module.ecs.this_private_ip
}

output "this_public_ip" {
  description = "The instance public ip"
  value       = module.ecs.this_public_ip
}

output "this_eip" {
  description = "The eip address"
  value       = alicloud_eip.this[*].ip_address
}

output "this_eip_association_instance_id" {
  description = "The instance id"
  value       = alicloud_eip_association.this_ecs[*].instance_id
}
output "this_eip_association_eip_id" {
  description = "The eip id"
  value       = alicloud_eip_association.this_ecs[*].allocation_id
}