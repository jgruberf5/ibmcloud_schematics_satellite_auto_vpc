##################################################################################
# ibm_resource_group - The IBM Cloud resource group to create the VPC
##################################################################################
variable "ibm_resource_group" {
  type        = string
  default     = "default"
  description = "The IBM Cloud resource group to create the VPC"
}

##################################################################################
# ibm_region - The IBM Cloud VPC Gen 2 region to create VPC environment
##################################################################################
variable "ibm_region" {
  default     = "us-south"
  description = "The IBM Cloud VPC Gen 2 region to create VPC environment"
}

##################################################################################
# ibm_vpc_index - The index ID for this IBM Gen2 VPC
##################################################################################
variable "ibm_vpc_index" {
  default     = "1"
  description = "The index ID for this IBM Gen2 VPC"
}

##################################################################################
# ibm_vpc_prefix - The IPv4 VPC cidr to use as network prefix for your VPC
##################################################################################
variable "ibm_vpc_prefix" {
  default     = ""
  description = "The IPv4 VPC cidr to use as network prefix in zone 1"
}

##################################################################################
# ibm_satellite_attach_delay - How long in minutes to wait for host attach
##################################################################################
variable "ibm_satellite_attach_delay" {
  default     = "10m"
  description = "How long in minutes to wait for host attach"
}

##################################################################################
# ibm_satellite_location_managed_from - The IKS metro to manage this location
##################################################################################
variable "ibm_satellite_location_managed_from" {
  default     = "dal10"
  description = "The IKS metro to manage this location (ibmcloud ks locations)"
}

##################################################################################
# ibm_ssh_key_name - The name of the existing SSH key to inject into infrastructure
##################################################################################
variable "ibm_ssh_key_name" {
  default     = ""
  description = "The name of the existing SSH key to inject into infrastructure"
}

##################################################################################
# ibm_resource_prefix - The resource name prefix
##################################################################################
variable "ibm_resource_prefix" {
  type        = string
  default     = "sat"
  description = "The resource name prefix"
}

##################################################################################
# ibm_control_profile - The name of the VPC profile to use for the control instances
##################################################################################
variable "ibm_control_profile" {
  type        = string
  default     = "bx2-4x16"
  description = "The name of the VPC profile to use for the control instances"
}

##################################################################################
# ibm_compute_profile - The name of the VPC profile to use for the compute instances
##################################################################################
variable "ibm_compute_profile" {
  type        = string
  default     = "bx2-16x64"
  description = "The name of the VPC profile to use for the compute instances"
}

##################################################################################
# ibm_vpn_profile - The name of the VPC profile to use for the vpn router
##################################################################################
variable "ibm_vpn_profile" {
  type        = string
  default     = "bx2-2x8"
  description = "The name of the VPC profile to use for the control instances"
}

##################################################################################
# ibm_nfs_profile - The name of the VPC profile to use for the nfs server
##################################################################################
variable "ibm_nfs_profile" {
  type        = string
  default     = "bx2-4x16"
  description = "The name of the VPC profile to use for the control instances"
}

##################################################################################
# ibm_security_group_id - The VPC security group ID
##################################################################################
variable "ibm_security_group_id" {
  default     = ""
  description = "The VPC security group ID"
}

##################################################################################
#  vpn_cidr - VPN cidr
##################################################################################
variable "vpn_cidr" {
  default     = "172.13.122.0/24"
  description = "VPN cidr"
}

##################################################################################
#  vpn_listen_port - VPN listen port
##################################################################################
variable "vpn_listen_port" {
  default     = 41194
  description = "VPN listen port"
}
