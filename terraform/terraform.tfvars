# General
yacloud_cloud_id = "b1g749urnclt893jg9nl"
yacloud_folder_id = "b1g36tb906nfmal4q580"
yacloud_key_file = "terraform_yc_key.json"
yacloud_default_zone_name = "ru-central1-b"

# Account
yacloud_service_account = {
  kubernetes_master = {
    yacloud_service_account_description = "service account for kubernetes master to manage cloud resources"
    yacloud_service_account_name = "kubernetes-master"
  }
  kubernetes_node = {
    yacloud_service_account_description = "service account for kubernetes node to pull docker images"
    yacloud_service_account_name = "kubernetes-node"
  }
}

# Net
yacloud_network_id = "enp0vvlva1pi4htrkpu4"
yacloud_subnet_id = "e2lh3l20g0i5irb6c39u"

# VPS
yacloud_centos7_image_id = "fd8o7eoifm3jdcqem43r"