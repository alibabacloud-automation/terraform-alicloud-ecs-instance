// Output the IDs of the ECS instances created
output "instance_ids" {
  value = "${join(",", alicloud_instance.instances.*.id)}"
}

// Output the IDs of the ECS disks created
output "disk_ids" {
  value = "${join(",", alicloud_disk.disks.*.id)}"
}
