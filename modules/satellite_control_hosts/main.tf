resource "ibm_satellite_host" "control_server_1" {
  location      = var.ibm_location_id
  host_id       = var.ibm_host_1_id
  labels        = ["env:demo"]
  zone          = "${var.ibm_region}-1"
  host_provider = "ibm"
}

resource "ibm_satellite_host" "control_server_2" {
  location      = var.ibm_location_id
  host_id       = var.ibm_host_2_id
  labels        = ["env:demo"]
  zone          = "${var.ibm_region}-2"
  host_provider = "ibm"
}

resource "ibm_satellite_host" "control_server_3" {
  location      = var.ibm_location_id
  host_id       = var.ibm_host_3_id
  labels        = ["env:demo"]
  zone          = "${var.ibm_region}-3"
  host_provider = "ibm"
}
