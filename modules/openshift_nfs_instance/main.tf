# lookup compute profile by name
data "ibm_is_instance_profile" "nfs_profile" {
  name = var.ibm_nfs_profile
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

data "ibm_is_vpc" "nfs_vpc" {
  name = data.ibm_is_subnet.subnet.vpc_name
}

locals {
  peer_prefix = replace(replace(var.ibm_resource_prefix, "-", ""), "_", "")
}

data "template_file" "nfs" {
  template = file("${path.module}/nfs_server.yaml")
}

locals {
  security_group_id = var.ibm_security_group_id == "" ? data.ibm_is_vpc.nfs_vpc.default_security_group : var.ibm_security_group_id
}


resource "ibm_is_volume" "nfs_server_host_01_vol_01" {
  name     = "${var.ibm_resource_prefix}-nfs-h1-v2"
  profile  = "custom"
  zone     = data.ibm_is_subnet.subnet.zone
  iops     = 5000
  capacity = 1000
}

# nfs server
resource "ibm_is_instance" "nfs-server" {
  name           = "${var.ibm_resource_prefix}-nfs-server"
  resource_group = data.ibm_resource_group.group.id
  image          = data.ibm_is_image.ubuntu.id
  profile        = data.ibm_is_instance_profile.nfs_profile.id
  primary_network_interface {
    name            = "internal"
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = [local.security_group_id]
  }
  vpc       = data.ibm_is_subnet.subnet.vpc
  zone      = data.ibm_is_subnet.subnet.zone
  keys      = [data.ibm_is_ssh_key.ssh_key.id]
  volumes   = [ibm_is_volume.nfs_server_host_01_vol_01.id]
  user_data = data.template_file.nfs.rendered
  timeouts {
    create = "60m"
    delete = "120m"
  }
}
