// Output the IDs of the ECS instances created
output "this_instance_id" {
  value = module.bare_metal_cpu_ecs_instance.this_instance_id
}

output "this_instance_name" {
  value = module.bare_metal_cpu_ecs_instance.this_instance_name
}

output "this_instance_type" {
  value = module.bare_metal_cpu_ecs_instance.this_instance_type
}

output "this_image_id" {
  value = module.bare_metal_cpu_ecs_instance.this_image_id
}

output "this_instance_tags" {
  value = module.bare_metal_cpu_ecs_instance.this_instance_tags
}

output "this_private_ip" {
  value = module.bare_metal_cpu_ecs_instance.this_private_ip
}

output "this_public_ip" {
  value = module.bare_metal_cpu_ecs_instance.this_public_ip
}

output "this_availability_zone" {
  value = module.bare_metal_cpu_ecs_instance.this_availability_zone
}

# VSwitch  ID
output "this_vswitch_id" {
  value = module.bare_metal_cpu_ecs_instance.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  value = module.bare_metal_cpu_ecs_instance.this_security_group_ids
}