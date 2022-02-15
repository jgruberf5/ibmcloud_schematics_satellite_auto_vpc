output "vpn_address" {
  value = ibm_is_floating_ip.vpn_router_floating_ip.address
}
output "client_configurations" {
  value = "scp root@${ibm_is_floating_ip.vpn_router_floating_ip.address}:/etc/wireguard/${substr(local.peer_prefix, 0, 10)}-wireguard-configs.zip ./"
}
