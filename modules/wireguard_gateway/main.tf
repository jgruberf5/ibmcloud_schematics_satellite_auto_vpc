# lookup compute profile by name
data "ibm_is_instance_profile" "vpn_profile" {
  name = var.ibm_vpn_profile
}

# lookup image name for a custom image in region if we need it
data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-20-04-2-minimal-amd64-1"
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.ibm_ssh_key_name
}

data "ibm_is_subnet" "subnet" {
  identifier = var.ibm_subnet_id
}

data "ibm_is_vpc" "vpn_vpc" {
  name = data.ibm_is_subnet.subnet.vpc_name
}

data "template_file" "wr" {
  template = file("${path.module}/wireguard_router.yaml")
  vars = {
    vpn_cidr              = var.vpn_cidr
    vpn_listen_port       = var.vpn_listen_port
    vpn_internal_networks = var.vpn_internal_networks
    vpn_peer_prefix       = replace(replace(var.ibm_resource_prefix, "-", ""), "_", "")
  }
}

locals {
  security_group_id = var.ibm_security_group_id == "" ? data.ibm_is_vpc.vpn_vpc.default_security_group : var.ibm_security_group_id
}


# wireguard router server
resource "ibm_is_instance" "vpn-router" {
  name           = "${var.ibm_resource_prefix}-vpn-router"
  resource_group = data.ibm_resource_group.group.id
  image          = data.ibm_is_image.ubuntu.id
  profile        = data.ibm_is_instance_profile.vpn_profile.id
  primary_network_interface {
    name            = "internal"
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = [local.security_group_id]
  }
  vpc       = data.ibm_is_subnet.subnet.vpc
  zone      = data.ibm_is_subnet.subnet.zone
  keys      = [data.ibm_is_ssh_key.ssh_key.id]
  user_data = data.template_file.wr.rendered
  timeouts {
    create = "60m"
    delete = "120m"
  }
}
resource "ibm_is_floating_ip" "vpn_router_floating_ip" {
  name           = "${var.ibm_resource_prefix}-vpn-router-fip"
  resource_group = data.ibm_resource_group.group.id
  target         = ibm_is_instance.vpn-router.primary_network_interface[0].id
}
