resource "yandex_compute_instance" "yacloud_vps_01" {
  name                      = "gitlab-grafana"
  hostname                  = "gitlab-grafana"
  description               = "gitlab-grafana server"
  platform_id               = "standard-v2"
  allow_stopping_for_update = "true"

  resources {
    cores         = "2"
    core_fraction = "20"
    memory        = "8"
  }

  scheduling_policy {
    preemptible = "true"
  }

  boot_disk {
    initialize_params {
      image_id = var.yacloud_centos7_image_id
      size     = "60"
    }
  }

  network_interface {
    subnet_id = var.yacloud_subnet_id
    nat       = "true"
  }

  metadata = {
    user-data = "${file("vps_user-data")}"
  }
}