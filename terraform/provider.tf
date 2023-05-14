terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.90.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.yacloud_key_file
  cloud_id                 = var.yacloud_cloud_id
  folder_id                = var.yacloud_folder_id
  zone                     = var.yacloud_default_zone_name
}