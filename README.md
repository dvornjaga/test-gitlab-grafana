# test-gitlab-grafana
## Before first run
1. Create [service account](https://cloud.yandex.ru/docs/iam/operations/sa/create) for terraform with roles `editor`
2. Create [authorized key](https://cloud.yandex.ru/docs/iam/operations/authorized-key/create) as `terraform_yc_key.json`
3. Add `terraform.tfvars` and `vps_user-data`

## Run
1. Run terraform init and terraform plan:
   ```
   terraform -chdir=terraform init
   terraform -chdir=terraform plan
   ```
2. Run terraform apply:
   ```
   terraform -chdir=terraform apply -auto-approve
   ```
3. Run playbook
   ```
   ansible-playbook -u ansible -i $(jq -r '.resources[] | select(.name == "yacloud_vps_01") | .instances[].attributes.network_interface[].nat_ip_address' terraform/terraform.tfstate), --extra-vars "gitlab_host=$(jq -r '.resources[] | select(.name == "yacloud_vps_01") | .instances[].attributes.network_interface[].nat_ip_address' terraform/terraform.tfstate)" ansible/gitlab_grafana.yml
   ```
4. Check IP address:
   ```
   jq -r '.resources[] | select(.name == "yacloud_vps_01") | .instances[].attributes.network_interface[].nat_ip_address' terraform/terraform.tfstate), --extra-vars "gitlab_host=$(jq -r '.resources[] | select(.name == "yacloud_vps_01") | .instances[].attributes.network_interface[].nat_ip_address' terraform/terraform.tfstate
   ```
5. Grafana will be available at http://ip/grafana (admin/admin)
6. Gitlab will be available at http://ip. User: root, password:
   ```
   docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
   ```
4. Generate kube.config:
   ```
   yc managed-kubernetes cluster get-credentials --id $(jq -r '.resources[] | select(.name == "yacloud_kubernetes_cluster") | .instances[].attributes.id' terraform/terraform.tfstate) --external --kubeconfig $HOME/.kube/kube.config
   ```
5. Create namespaces:
   ```
   kubectl create ns monitoring
   ```
6. Install kube-prometheus-stack
   ```
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   helm install -n monitoring -f helm/kube-prometheus-stack/values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack
   ```
7. Kubernetes Grafana will appear at:
   ```
   kubectl describe services -n monitoring kube-prometheus-stack-grafana | grep Ingress
   ```
## Destroy
1. Run terraform destroy:
   ```
   terraform -chdir=terraform destroy
   ```