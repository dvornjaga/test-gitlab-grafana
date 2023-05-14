resource "yandex_kubernetes_cluster" "yacloud_kubernetes_cluster" {
  name        = "kubernetes-cluster-01"
  description = "kubernetes cluster for test project"
  network_id = var.yacloud_network_id
  cluster_ipv4_range = "10.109.0.0/16"
  service_ipv4_range = "10.209.0.0/16"
  master {
    version = "1.24"
    zonal {
      zone      = var.yacloud_default_zone_name
      subnet_id = var.yacloud_subnet_id
    }
    public_ip = true
    maintenance_policy {
      auto_upgrade = true
      maintenance_window {
        day        = "saturday"
        start_time = "03:00"
        duration   = "3h"
      }
      maintenance_window {
        day        = "sunday"
        start_time = "03:00"
        duration   = "3h"
      }
    }
  }
  service_account_id      = yandex_iam_service_account.yacloud_service_account["kubernetes_master"].id
  node_service_account_id = yandex_iam_service_account.yacloud_service_account["kubernetes_node"].id
  release_channel = "REGULAR"
}

resource "yandex_kubernetes_node_group" "yacloud_kubernetes_node_group" {
  cluster_id  = yandex_kubernetes_cluster.yacloud_kubernetes_cluster.id
  name        = "kubernetes-node-group-01"
  description = "kubernetes node group for test project"
  version     = "1.24"
  instance_template {
    platform_id = "standard-v2"
    name        = "{instance.short_id}-kubernetes-node"
    network_interface {
      nat                = true
      subnet_ids         = ["${var.yacloud_subnet_id}"]
    }
    resources {
      memory        = 8
      cores         = 2
      core_fraction = 20
    }
    boot_disk {
      type = "network-hdd"
      size = 80
    }
    scheduling_policy {
      preemptible = true
    }
    container_runtime {
      type = "containerd"
    }
  }
  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  allocation_policy {
    location {
      zone = var.yacloud_default_zone_name
    }
  }
  deploy_policy {
    max_unavailable = 3
    max_expansion   = 3
  }
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
    maintenance_window {
      day        = "saturday"
      start_time = "06:00"
      duration   = "3h"
    }
    maintenance_window {
      day        = "sunday"
      start_time = "06:00"
      duration   = "3h"
    }
  }
}