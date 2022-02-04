module "ibm_vpc" {
  source             = "./modules/ibm_vpc"
  ibm_region         = var.ibm_region
  ibm_resource_group = var.ibm_resource_group
  ibm_ssh_key_name   = var.ibm_ssh_key_name
  ibm_vpc_name       = var.ibm_resource_prefix
  #ibm_vpc_zone_1_prefix = var.ibm_vpc_zone_1_prefix
  #ibm_vpc_zone_2_prefix = var.ibm_vpc_zone_2_prefix
  #ibm_vpc_zone_3_prefix = var.ibm_vpc_zone_3_prefix
  ibm_vpc_index = var.ibm_vpc_index
}

module "satellite_hosts" {
  source                = "./modules/satellite_hosts"
  ibm_resource_group    = var.ibm_resource_group
  ibm_region            = var.ibm_region
  ibm_resource_prefix   = var.ibm_resource_prefix
  ibm_control_profile   = var.ibm_control_profile
  ibm_compute_profile   = var.ibm_compute_profile
  ibm_ssh_key_name      = var.ibm_ssh_key_name
  ibm_zone_1_subnet_id  = module.ibm_vpc.vpc_zone_1_subnet_id
  ibm_zone_2_subnet_id  = module.ibm_vpc.vpc_zone_2_subnet_id
  ibm_zone_3_subnet_id  = module.ibm_vpc.vpc_zone_3_subnet_id
  ibm_security_group_id = module.ibm_vpc.vpc_default_security_group_id
}

module "wireguard_gateway" {
  source                = "./modules/wireguard_gateway"
  ibm_resource_group    = var.ibm_resource_group
  ibm_region            = var.ibm_region
  ibm_ssh_key_name      = var.ibm_ssh_key_name
  ibm_resource_prefix   = var.ibm_resource_prefix
  ibm_vpn_profile       = var.ibm_vpn_profile
  ibm_subnet_id         = module.ibm_vpc.vpc_zone_1_subnet_id
  ibm_security_group_id = module.ibm_vpc.vpc_default_security_group_id
  vpn_cidr              = var.vpn_cidr
  vpn_listen_port       = var.vpn_listen_port
  vpn_internal_networks = "${module.ibm_vpc.vpc_zone_1_subnet_cidr}, ${module.ibm_vpc.vpc_zone_2_subnet_cidr}, ${module.ibm_vpc.vpc_zone_3_subnet_cidr}"
}
