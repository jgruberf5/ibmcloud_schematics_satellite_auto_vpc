resource "ibm_satellite_cluster" "cluster" {
  name                = "${var.ibm_resource_prefix}-cluster"
  location            = var.ibm_location_id
  enable_config_admin = true
  kube_version        = "4.8_openshift"
  resource_group_id   = data.ibm_resource_group.group.id
  worker_count        = 1
}
