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
# ibm_resource_prefix - The resource name prefix
##################################################################################
variable "ibm_resource_prefix" {
  type        = string
  default     = "sat"
  description = "The resource name prefix"
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
# ibm_ssh_key_name - The name of the existing SSH key to inject into infrastructure
##################################################################################
variable "ibm_ssh_key_name" {
  default     = ""
  description = "The name of the existing SSH key to inject into infrastructure"
}

##################################################################################
# ibm_subnet_id - The VPC subnet ID to vpn router
##################################################################################
variable "ibm_subnet_id" {
  default     = ""
  description = "The VPC subnet ID to vpn router"
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

##################################################################################
#  vpn_internal_networks - The internal networks the VPN can route to
##################################################################################
variable "vpn_internal_networks" {
  default     = "10.241.0.0/16"
  description = "The internal networks the VPN can route to"
}
