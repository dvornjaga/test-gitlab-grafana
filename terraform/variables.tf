variable "yacloud_centos7_image_id" {
  type        = string
  description = "Yandex Cloud Centos 7 image ID."
  sensitive   = true
}

variable "yacloud_cloud_id" {
  type        = string
  description = "Yandex Cloud ID."
  sensitive   = true
}

variable "yacloud_default_zone_name" {
  type        = string
  description = "Yandex Cloud default zone name to operate under."
}

variable "yacloud_folder_id" {
  type        = string
  description = "Yandex Cloud folder ID."
  sensitive   = true
}

variable "yacloud_key_file" {
  type        = string
  description = "Path to key.json."
}

variable "yacloud_network_id" {
  type        = string
  description = "Yandex Cloud network ID."
}

variable "yacloud_service_account" {
  type        = map
  description = "Yandex Cloud service account mapping."
}

variable "yacloud_subnet_id" {
  type        = string
  description = "Yandex Cloud subnet ID."
}