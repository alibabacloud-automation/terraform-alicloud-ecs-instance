// Output the IDs of the ECS instances created
output "this_instance_id" {
  value = module.example.this_instance_id
}

output "this_instance_name" {
  value = module.example.this_instance_name
}

output "this_instance_type" {
  value = module.example.this_instance_type
}

output "this_image_id" {
  value = module.example.this_image_id
}

output "this_instance_tags" {
  value = module.example.this_instance_tags
}

output "this_private_ip" {
  value = module.example.this_private_ip
}

output "this_public_ip" {
  value = module.example.this_public_ip
}

output "this_availability_zone" {
  value = module.example.this_availability_zone
}

# VSwitch  ID
output "this_vswitch_id" {
  value = module.example.this_vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  value = module.example.this_security_group_ids
}