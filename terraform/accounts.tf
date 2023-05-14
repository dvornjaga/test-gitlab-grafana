resource "yandex_iam_service_account" "yacloud_service_account" {
  for_each = var.yacloud_service_account
  name        = each.value.yacloud_service_account_name
  description = each.value.yacloud_service_account_description
}

resource "yandex_resourcemanager_folder_iam_binding" "yacloud_iam_binding_editor" {
  folder_id = var.yacloud_folder_id
  role = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.yacloud_service_account["kubernetes_master"].id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "yacloud_iam_binding_images_puller" {
  folder_id = var.yacloud_folder_id
  role = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.yacloud_service_account["kubernetes_node"].id}",
  ]
}