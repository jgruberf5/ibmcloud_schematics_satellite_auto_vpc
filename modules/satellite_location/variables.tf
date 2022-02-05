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
# ibm_location_managed_from - The IKS metro to manage this location
##################################################################################
variable "ibm_location_managed_from" {
  type        = string
  default     = "dal10"
  description = "The IKS metro to manage this location (ibmcloud ks locations)"
}
