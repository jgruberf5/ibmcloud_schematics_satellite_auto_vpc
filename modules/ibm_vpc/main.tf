locals {
  prefix_management = var.ibm_vpc_prefix == "" ? "auto" : "manual"
  prefix_create     = var.ibm_vpc_prefix == "" ? 0 : 1
  zone_prefix_1     = var.ibm_vpc_prefix == "" ? "" : cidrsubnet(var.ibm_vpc_prefix, (23 - (split("/", var.ibm_vpc_prefix)[1])), 0)
  zone_prefix_2     = var.ibm_vpc_prefix == "" ? "" : cidrsubnet(var.ibm_vpc_prefix, (23 - (split("/", var.ibm_vpc_prefix)[1])), 1)
  zone_prefix_3     = var.ibm_vpc_prefix == "" ? "" : cidrsubnet(var.ibm_vpc_prefix, (23 - (split("/", var.ibm_vpc_prefix)[1])), 2)
}

resource "ibm_is_vpc" "vpc" {
  name                      = "${var.ibm_vpc_name}-${var.ibm_region}-${var.ibm_vpc_index}"
  resource_group            = data.ibm_resource_group.group.id
  address_prefix_management = local.prefix_management
}

resource "ibm_is_vpc_address_prefix" "zone_1_vpc_address_prefix" {
  count = local.prefix_create
  name  = "${var.ibm_vpc_name}-${var.ibm_region}-1-${var.ibm_vpc_index}-ap"
  zone  = "${var.ibm_region}-1"
  vpc   = ibm_is_vpc.vpc.id
  cidr  = local.zone_prefix_1
}

resource "ibm_is_vpc_address_prefix" "zone_2_vpc_address_prefix" {
  count = local.prefix_create
  name  = "${var.ibm_vpc_name}-${var.ibm_region}-2-${var.ibm_vpc_index}-ap"
  zone  = "${var.ibm_region}-2"
  vpc   = ibm_is_vpc.vpc.id
  cidr  = local.zone_prefix_2
}

resource "ibm_is_vpc_address_prefix" "zone_3_vpc_address_prefix" {
  count = local.prefix_create
  name  = "${var.ibm_vpc_name}-${var.ibm_region}-3-${var.ibm_vpc_index}-ap"
  zone  = "${var.ibm_region}-3"
  vpc   = ibm_is_vpc.vpc.id
  cidr  = local.zone_prefix_3
}

// allow all inbound
resource "ibm_is_security_group_rule" "allow_inbound" {
  depends_on = [ibm_is_vpc.vpc]
  group      = ibm_is_vpc.vpc.default_security_group
  direction  = "inbound"
  remote     = "0.0.0.0/0"
}

// all all outbound
resource "ibm_is_security_group_rule" "allow_outbound" {
  depends_on = [ibm_is_vpc.vpc]
  group      = ibm_is_vpc.vpc.default_security_group
  direction  = "outbound"
  remote     = "0.0.0.0/0"
}

data "ibm_is_vpc_address_prefixes" "vpc_prefixes" {
  vpc = ibm_is_vpc.vpc.id
  depends_on = [
    ibm_is_vpc_address_prefix.zone_1_vpc_address_prefix,
    ibm_is_vpc_address_prefix.zone_2_vpc_address_prefix,
    ibm_is_vpc_address_prefix.zone_3_vpc_address_prefix
  ]
}

locals {
  ap_1_zone = data.ibm_is_vpc_address_prefixes.vpc_prefixes.address_prefixes[0].zone[0].name
  ap_1_cidr = data.ibm_is_vpc_address_prefixes.vpc_prefixes.address_prefixes[0].cidr
  ap_2_zone = data.ibm_is_vpc_address_prefixes.vpc_prefixes.address_prefixes[1].zone[0].name
  ap_2_cidr = data.ibm_is_vpc_address_prefixes.vpc_prefixes.address_prefixes[1].cidr
  ap_3_zone = data.ibm_is_vpc_address_prefixes.vpc_prefixes.address_prefixes[2].zone[0].name
  ap_3_cidr = data.ibm_is_vpc_address_prefixes.vpc_prefixes.address_prefixes[2].cidr
}

resource "ibm_is_public_gateway" "zone_1_gw" {
  name = "${var.ibm_vpc_name}-${var.ibm_region}-pg-${local.ap_1_zone}"
  vpc  = ibm_is_vpc.vpc.id
  zone = local.ap_1_zone
  timeouts {
    create = "90m"
  }
  depends_on = [data.ibm_is_vpc_address_prefixes.vpc_prefixes]
}

resource "ibm_is_subnet" "zone_1" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-sn-${local.ap_1_zone}"
  vpc             = ibm_is_vpc.vpc.id
  zone            = local.ap_1_zone
  resource_group  = data.ibm_resource_group.group.id
  ipv4_cidr_block = cidrsubnet(local.ap_1_cidr, (24 - (split("/", local.ap_1_cidr)[1])), 0)
  public_gateway  = ibm_is_public_gateway.zone_1_gw.id
  depends_on      = [data.ibm_is_vpc_address_prefixes.vpc_prefixes]
}

resource "ibm_is_public_gateway" "zone_2_gw" {
  name = "${var.ibm_vpc_name}-${var.ibm_region}-pg-${local.ap_2_zone}"
  vpc  = ibm_is_vpc.vpc.id
  zone = local.ap_2_zone
  timeouts {
    create = "90m"
  }
  depends_on = [data.ibm_is_vpc_address_prefixes.vpc_prefixes]
}

resource "ibm_is_subnet" "zone_2" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-sn-${local.ap_2_zone}"
  vpc             = ibm_is_vpc.vpc.id
  zone            = local.ap_2_zone
  resource_group  = data.ibm_resource_group.group.id
  ipv4_cidr_block = cidrsubnet(local.ap_2_cidr, (24 - (split("/", local.ap_2_cidr)[1])), 0)
  public_gateway  = ibm_is_public_gateway.zone_2_gw.id
  depends_on      = [data.ibm_is_vpc_address_prefixes.vpc_prefixes]
}

resource "ibm_is_public_gateway" "zone_3_gw" {
  name = "${var.ibm_vpc_name}-${var.ibm_region}-pg-${local.ap_3_zone}"
  vpc  = ibm_is_vpc.vpc.id
  zone = local.ap_3_zone
  timeouts {
    create = "90m"
  }
  depends_on = [data.ibm_is_vpc_address_prefixes.vpc_prefixes]
}

resource "ibm_is_subnet" "zone_3" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-sn-${local.ap_3_zone}"
  vpc             = ibm_is_vpc.vpc.id
  zone            = local.ap_3_zone
  resource_group  = data.ibm_resource_group.group.id
  ipv4_cidr_block = cidrsubnet(local.ap_3_cidr, (24 - (split("/", local.ap_3_cidr)[1])), 0)
  public_gateway  = ibm_is_public_gateway.zone_3_gw.id
  depends_on      = [data.ibm_is_vpc_address_prefixes.vpc_prefixes]
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.ibm_ssh_key_name
}
