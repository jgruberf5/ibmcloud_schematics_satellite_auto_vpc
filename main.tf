module "ibm_vpc" {
  source             = "./modules/ibm_vpc"
  ibm_region         = var.ibm_region
  ibm_resource_group = var.ibm_resource_group
  ibm_ssh_key_name   = var.ibm_ssh_key_name
  ibm_vpc_name       = var.ibm_resource_prefix
  ibm_vpc_prefix     = var.ibm_vpc_prefix
  ibm_vpc_index      = var.ibm_vpc_index
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

module "satellite_control_instances" {
  source                     = "./modules/satellite_control_instances"
  ibm_resource_group         = var.ibm_resource_group
  ibm_region                 = var.ibm_region
  ibm_resource_prefix        = var.ibm_resource_prefix
  ibm_control_profile        = var.ibm_control_profile
  ibm_ssh_key_name           = var.ibm_ssh_key_name
  ibm_zone_1_subnet_id       = module.ibm_vpc.vpc_zone_1_subnet_id
  ibm_zone_2_subnet_id       = module.ibm_vpc.vpc_zone_2_subnet_id
  ibm_zone_3_subnet_id       = module.ibm_vpc.vpc_zone_3_subnet_id
  ibm_security_group_id      = module.ibm_vpc.vpc_default_security_group_id
  ibm_attach_script          = module.satellite_location.ibm_satellite_location_host_attach_script
  ibm_satellite_location_id  = module.satellite_location.ibm_satellite_location_id
  ibm_satellite_attach_delay = var.ibm_satellite_attach_delay
}

# IBM VPC host IDs are not the same as Satellite host IDs.. and
# There is no obvious mapping... so we have to delay and wait for
# the attach scripts to attach the hosts to our satellite location.
# After they are attached we can poll for their satellite host ids.

#module "satellite_control_hosts" {
#  source              = "./modules/satellite_control_hosts"
#  ibm_resource_group  = var.ibm_resource_group
#  ibm_region          = var.ibm_region
#  ibm_resource_prefix = var.ibm_resource_prefix
#  ibm_location_id     = module.satellite_location.ibm_satellite_location_id
#  ibm_host_1_id       = module.satellite_control_instances.control_server_1_satellite_host_id
#  ibm_host_2_id       = module.satellite_control_instances.control_server_2_satellite_host_id
#  ibm_host_3_id       = module.satellite_control_instances.control_server_3_satellite_host_id
#}

module "satellite_compute_instances" {
  source                     = "./modules/satellite_compute_instances"
  ibm_resource_group         = var.ibm_resource_group
  ibm_region                 = var.ibm_region
  ibm_resource_prefix        = var.ibm_resource_prefix
  ibm_compute_profile        = var.ibm_compute_profile
  ibm_ssh_key_name           = var.ibm_ssh_key_name
  ibm_zone_1_subnet_id       = module.ibm_vpc.vpc_zone_1_subnet_id
  ibm_zone_2_subnet_id       = module.ibm_vpc.vpc_zone_2_subnet_id
  ibm_zone_3_subnet_id       = module.ibm_vpc.vpc_zone_3_subnet_id
  ibm_security_group_id      = module.ibm_vpc.vpc_default_security_group_id
  ibm_attach_script          = module.satellite_location.ibm_satellite_location_host_attach_script
  ibm_satellite_location_id  = module.satellite_location.ibm_satellite_location_id
  ibm_satellite_attach_delay = var.ibm_satellite_attach_delay
}

#module "satellite_cluster" {
#  source               = "./modules/satellite_cluster"
#  ibm_resource_group   = var.ibm_resource_group
#  ibm_region           = var.ibm_region
#  ibm_resource_prefix  = var.ibm_resource_prefix
#  ibm_location_id      = module.satellite_location.ibm_satellite_location_id
#  ibm_worker_host_1_id = module.satellite_compute_instances.compute_server_1_id
#  ibm_worker_host_2_id = module.satellite_compute_instances.compute_server_2_id
#  ibm_worker_host_3_id = module.satellite_compute_instances.compute_server_3_id
#}
