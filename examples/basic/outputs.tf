// Output the IDs of the ECS instances created
output "this_instance_ids" {
  value = module.ecs.this_instance_id
}

output "this_instance_names" {
  value = module.ecs.this_instance_name
}

# VSwitch  ID
output "this_vswitch_ids" {
  value = module.ecs.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  value = module.ecs.this_security_group_ids
}

output "this_private_ip" {
  value = module.ecs.this_private_ip
}

output "this_tags" {
  value = module.ecs.this_instance_tags
}

output "t5_instance_id" {
  description = "ECS instance ID"
  value       = module.ecs_with_t5_unlimited.this_instance_id[0]
}

output "credit_specification" {
  description = "Credit specification of ECS instance (empty list for not t6 instance types)"
  value       = module.ecs.this_credit_specification
}

output "credit_specification_t5_unlimited" {
  description = "Credit specification of t5-type ECS instance"
  value       = module.ecs_with_t5_unlimited.this_credit_specification
}