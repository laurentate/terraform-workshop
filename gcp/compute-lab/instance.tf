terraform {
  required_version = "> 0.12.0"
}

//Data Sources
data "google_compute_subnetwork" "private_subnet_london" {
  name   = "private-subnet--london"
  region = "europe-west2"
}

data "google_compute_subnetwork" "public_subnet_london" {
  name   = "public-subnet--london"
  region = "europe-west2"
}

data "local_file" "index" {
  filename = "index.html"
}

//Resources
resource "google_compute_instance_template" "appserver" {
  name_prefix = "${var.stack_prefix}appserver-template"
  description = "This template is used to create app server instances."


  labels = {
    environment = "demo"
  }

  instance_description = "description assigned to instances"
  machine_type         = var.machine_type
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-1804-lts"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.public_subnet_london.name
# Give this instance a public IP in the absence of a public loadbalancer
    access_config {}

  }

  service_account {
    email  = var.svca_pub_inb_out
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata_startup_script = <<SCRIPT
    apt -y update
    apt -y install apache2
    export HOSTNAME=$(hostname | tr -d '\n')
    export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
    echo "${data.local_file.index.content}" > /var/www/html/index.html
    systemctl restart apache2
    SCRIPT
}

resource "google_compute_instance_group_manager" "appserver" {
  name = "${var.stack_prefix}appserver-1"

  base_instance_name = "app"
  zone               = var.region_zone

  version {
    instance_template = google_compute_instance_template.appserver.self_link
  }

  target_size = 1

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 1
    max_unavailable_fixed = 0
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_autoscaler" "appserver_autoscaler" {
  name   = "${var.stack_prefix}app-server-autoscaler"
  zone   = var.region_zone
  target = google_compute_instance_group_manager.appserver.self_link

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}