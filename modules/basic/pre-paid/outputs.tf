// Output the IDs of the ECS instances created
output "this_instance_id" {
  value = module.ecs-instance.this_instance_id
}

output "this_instance_name" {
  value = module.ecs-instance.this_instance_name
}

# VSwitch  ID
output "this_vswitch_id" {
  value = module.ecs-instance.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  value = module.ecs-instance.this_security_group_ids
}

output "this_private_ip" {
  value = module.ecs-instance.this_private_ip
}