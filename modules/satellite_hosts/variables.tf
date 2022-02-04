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
  default     = "bx2-8x32"
  description = "The name of the VPC profile to use for the compute instances"
}

##################################################################################
# ibm_ssh_key_name - The name of the existing SSH key to inject into infrastructure
##################################################################################
variable "ibm_ssh_key_name" {
  default     = ""
  description = "The name of the existing SSH key to inject into infrastructure"
}

##################################################################################
# ibm_zone_1_subnet_id - The VPC subnet ID to connect servers in Zone 1
##################################################################################
variable "ibm_zone_1_subnet_id" {
  default     = ""
  description = "The VPC subnet ID to connect servers in Zone 1"
}

##################################################################################
# ibm_zone_2_subnet_id - The VPC subnet ID to connect the servers in Zone 2
##################################################################################
variable "ibm_zone_2_subnet_id" {
  default     = ""
  description = "The VPC subnet ID to connect the servers in Zone 2"
}

##################################################################################
# ibm_zone_3_subnet_id - The VPC subnet ID to connect the servers in Zone 3
##################################################################################
variable "ibm_zone_3_subnet_id" {
  default     = ""
  description = "The VPC subnet ID to connect the servers in Zone 3"
}

##################################################################################
# ibm_security_group_id - The VPC security group ID
##################################################################################
variable "ibm_security_group_id" {
  default     = ""
  description = "The VPC security group ID"
}
