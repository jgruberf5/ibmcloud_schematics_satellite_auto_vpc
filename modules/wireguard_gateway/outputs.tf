output "vpn_address" {
  value = ibm_is_floating_ip.vpn_router_floating_ip.address
}
output "client_configurations" {
  value = "scp root@${ibm_is_floating_ip.vpn_router_floating_ip.address}:/etc/wireguard/${local.peer_prefix}-wireguard-configs"
}
