resource "random_string" "location_unique" {
  length  = 8
  special = false
}
resource "ibm_satellite_location" "location" {
  location          = "${var.ibm_resource_prefix}-location-${random_string.location_unique.id}"
  zones             = ["${var.ibm_region}-1", "${var.ibm_region}-2", "${var.ibm_region}-3"]
  managed_from      = var.ibm_location_managed_from
  resource_group_id = data.ibm_resource_group.group.id
}

data "ibm_satellite_attach_host_script" "attach_script" {
  location      = ibm_satellite_location.location.id
  host_provider = "ibm"
}
