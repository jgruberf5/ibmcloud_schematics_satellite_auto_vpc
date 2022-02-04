output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "vpc_default_security_group_id" {
  value = ibm_is_vpc.vpc.default_security_group
}

output "vpc_zone_1_subnet_id" {
  value = ibm_is_subnet.zone_1.id
}

output "vpc_zone_1_subnet_cidr" {
  value = ibm_is_subnet.zone_1.ipv4_cidr_block
}

output "vpc_zone_2_subnet_id" {
  value = ibm_is_subnet.zone_2.id
}

output "vpc_zone_2_subnet_cidr" {
  value = ibm_is_subnet.zone_2.ipv4_cidr_block
}

output "vpc_zone_3_subnet_id" {
  value = ibm_is_subnet.zone_3.id
}

output "vpc_zone_3_subnet_cidr" {
  value = ibm_is_subnet.zone_3.ipv4_cidr_block
}
