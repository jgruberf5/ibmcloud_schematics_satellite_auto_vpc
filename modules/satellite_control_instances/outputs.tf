output "control_server_1_id" {
  value = ibm_is_instance.control_server_01_instance.id
}
output "control_server_1_name" {
  value = ibm_is_instance.control_server_01_instance.name
}
output "control_server_1_ip" {
  value = ibm_is_instance.control_server_01_instance.primary_network_interface.0.primary_ipv4_address
}
output "control_server_1_satellite_host_id" {
  value = data.ibm_satellite_location.location.hosts.0.host_id
}
output "control_server_2_id" {
  value = ibm_is_instance.control_server_02_instance.id
}
output "control_server_2_name" {
  value = ibm_is_instance.control_server_02_instance.name
}
output "control_server_2_ip" {
  value = ibm_is_instance.control_server_02_instance.primary_network_interface.0.primary_ipv4_address
}
output "control_server_2_satellite_host_id" {
  value = data.ibm_satellite_location.location.hosts.1.host_id
}
output "control_server_3_id" {
  value = ibm_is_instance.control_server_03_instance.id
}
output "control_server_3_name" {
  value = ibm_is_instance.control_server_03_instance.name
}
output "control_server_3_ip" {
  value = ibm_is_instance.control_server_03_instance.primary_network_interface.0.primary_ipv4_address
}
output "control_server_3_satellite_host_id" {
  value = data.ibm_satellite_location.location.hosts.2.host_id
}

#output "control_server_attached_location" {
#  value = data.ibm_satellite_location.location
#}
