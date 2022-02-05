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
# ibm_location_id - The Satellite Location ID
##################################################################################
variable "ibm_location_id" {
  type        = string
  default     = ""
  description = "The Satellite Location ID"
}


##################################################################################
# ibm_host_1_id - The VPC VSI instance ID for the control server
##################################################################################
variable "ibm_host_1_id" {
  type        = string
  default     = ""
  description = "The VPC VSI instance ID for the control server"
}

##################################################################################
# ibm_host_2_id - The VPC VSI instance ID for the control server
##################################################################################
variable "ibm_host_2_id" {
  type        = string
  default     = ""
  description = "The VPC VSI instance ID for the control server"
}

##################################################################################
# ibm_host_3_id - The VPC VSI instance ID for the control server
##################################################################################
variable "ibm_host_3_id" {
  type        = string
  default     = ""
  description = "The VPC VSI instance ID for the control server"
}
