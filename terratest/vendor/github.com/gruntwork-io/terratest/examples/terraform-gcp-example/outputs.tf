output "instance_id" {
  value = "${google_compute_instance.example.id}"
}

output "public_ip" {
  value = "${google_compute_instance.example.network_interface.0.access_config.0.nat_ip}"
}

output "bucket_url" {
  value = "${google_storage_bucket.example_bucket.url}"
}
