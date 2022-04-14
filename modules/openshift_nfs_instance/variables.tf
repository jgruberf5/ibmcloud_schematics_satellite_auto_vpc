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
# ibm_nfs_profile - The name of the VPC profile to use for the nfs server
##################################################################################
variable "ibm_nfs_profile" {
  type        = string
  default     = "bx2-4x16"
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
