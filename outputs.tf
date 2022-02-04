output "vpc_id" {
  value       = module.ibm_vpc.vpc_id
  description = "Satellite VPC identifier"
}

output "zone_1_subnet_id" {
  value       = module.ibm_vpc.vpc_zone_1_subnet_id
  description = "Satellite VPC Zone 1 subnet indentifier"
}

output "zone_1_subnet_cidr" {
  value       = module.ibm_vpc.vpc_zone_1_subnet_cidr
  description = "Satellite inside Zone 1 IPv4 CIDR"
}

output "zone_2_subnet_id" {
  value       = module.ibm_vpc.vpc_zone_2_subnet_id
  description = "Satellite VPC Zone 2 subnet indentifier"
}

output "zone_2_subnet_cidr" {
  value       = module.ibm_vpc.vpc_zone_2_subnet_cidr
  description = "Satellite Zone 2 IPv4 CIDR"
}

output "zone_3_subnet_id" {
  value       = module.ibm_vpc.vpc_zone_3_subnet_id
  description = "Satellite VPC Zone 3 subnet indentifier"
}

output "zone_3_subnet_cidr" {
  value       = module.ibm_vpc.vpc_zone_3_subnet_cidr
  description = "Satellite Zone 3 IPv4 CIDR"
}

output "vpn_address" {
  value       = module.wireguard_gateway.vpn_address
  description = "The VPN router public address"
}
