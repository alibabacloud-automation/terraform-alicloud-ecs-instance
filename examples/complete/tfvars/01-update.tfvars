#alicloud_kms_key
pending_window_in_days = 7

#alicloud_ram_role
document = <<EOF
		{
		  "Statement": [
			{
			  "Action": "sts:AssumeRole",
			  "Effect": "Allow",
			  "Principal": {
				"Service": [
				  "ecs.aliyuncs.com"
				]
			  }
			}
		  ],
		  "Version": "1"
		}
	  EOF

# Ecs instance variables
private_ip                 = "172.16.0.12"
private_ips                = ["172.16.0.12"]
name                       = "update-tf-testacc-name"
host_name                  = "update-tf-testacc-host-name"
description                = "update-tf-testacc-description"
internet_charge_type       = "PayByBandwidth"
password                   = "YourPassword123!update"
kms_encrypted_password     = "YourPassword123!update"
# system_disk_size           = 50
internet_max_bandwidth_out = 20
subscription = {
  period             = 1
  period_unit        = "Week"
  renewal_status     = "Normal"
  auto_renew_period  = 1
  include_data_disks = false
}
dry_run             = true
user_data           = "update-tf-user-data"
deletion_protection = false
force_delete        = true
tags = {
  Name = "updateECS"
}
volume_tags = {
  Name = "update-tf-testacc-ecs"
}