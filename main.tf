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

module "satellite_location" {
  source                    = "./modules/satellite_location"
  ibm_resource_group        = var.ibm_resource_group
  ibm_region                = var.ibm_region
  ibm_resource_prefix       = var.ibm_resource_prefix
  ibm_location_managed_from = var.ibm_satellite_location_managed_from
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
  ibm_attach_script     = module.satellite_location.ibm_satellite_location_host_attach_script
}

# IBM VPC host IDs are not the same as Satellite host IDs.. and
# There is no obvious mapping... so we have a chicken and egg problem
# with setting up the control plan hosts .. do it manually until
# we figure out what they want
# I can write a module script which would poll the satellite location
# until the hosts attach and get the generated hostids from there, then
# we can use the terrafrom to create the control plan

#module "satellite_control_hosts" {
#  source              = "./modules/satellite_control_hosts"
#  ibm_resource_group  = var.ibm_resource_group
#  ibm_region          = var.ibm_region
#  ibm_resource_prefix = var.ibm_resource_prefix
#  ibm_location_id     = module.satellite_location.ibm_satellite_location_id
#  ibm_host_1_id       = module.satellite_hosts.control_server_1_id
#  ibm_host_2_id       = module.satellite_hosts.control_server_2_id
#  ibm_host_3_id       = module.satellite_hosts.control_server_3_id
#}

# This is pretty useless as the time from attaching the hosts to the
# Satellite location and getting them provisioned as the location control
# plan can be an hour or more. Might as well watch it yourself and complete
# this step.
#module "satellite_cluster" {
#  source              = "./modules/satellite_cluster"
#  ibm_resource_group  = var.ibm_resource_group
#  ibm_region          = var.ibm_region
#  ibm_resource_prefix = var.ibm_resource_prefix
#  ibm_location_id     = module.satellite_location.ibm_satellite_location_id
# do this to slow down the creation
#  ibm_worker_host_1_id = module.satellite_hosts.compute_server_1_id
#  ibm_worker_host_2_id = module.satellite_hosts.compute_server_2_id
#  ibm_worker_host_3_id = module.satellite_hosts.compute_server_3_id
#}
