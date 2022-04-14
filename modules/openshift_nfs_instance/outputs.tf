output "nfs_address" {
  value = ibm_is_instance.nfs-server.primary_network_interface.0.primary_ipv4_address
}
