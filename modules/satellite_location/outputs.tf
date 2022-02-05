output "ibm_satellite_location_id" {
  value = ibm_satellite_location.location.id
}

output "ibm_satellite_location_host_attach_script" {
  value = data.ibm_satellite_attach_host_script.attach_script.host_script
}
