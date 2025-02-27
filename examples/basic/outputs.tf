# Output the IDs of the ECS instances created
output "this_instance_ids" {
  description = "The instance ids."
  value       = module.ecs.this_instance_id
}

output "this_instance_names" {
  description = "The instance names."
  value       = module.ecs.this_instance_name
}

# VSwitch  ID
output "this_vswitch_ids" {
  description = "The vswitch id in which the instance."
  value       = module.ecs.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  description = "The security group ids in which the instance."
  value       = module.ecs.this_security_group_ids
}

output "this_private_ip" {
  description = "The private ip of the instance."
  value       = module.ecs.this_private_ip
}

output "this_tags" {
  description = "The tags for the instance."
  value       = module.ecs.this_instance_tags
}

output "credit_specification" {
  description = "Credit specification of ECS instance (empty list for not t6 instance types)."
  value       = module.ecs.this_credit_specification
}
