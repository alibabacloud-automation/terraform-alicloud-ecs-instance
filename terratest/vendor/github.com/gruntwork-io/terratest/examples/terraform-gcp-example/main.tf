

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A CLOUD INSTANCE RUNNING UBUNTU
# See test/terraform_gcp_example_test.go for how to write automated tests for this code.
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_instance" "example" {
  project = "${var.gcp_project_id}"
  name = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A GOOGLE STORAGE BUCKET
# ---------------------------------------------------------------------------------------------------------------------

resource "google_storage_bucket" "example_bucket" {
  project = "${var.gcp_project_id}"
  name = "${var.bucket_name}"
  location = "${var.bucket_location}"
}
