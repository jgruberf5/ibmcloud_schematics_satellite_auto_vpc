# lookup compute profile by name
data "ibm_is_instance_profile" "compute_profile" {
  name = var.ibm_compute_profile
}

# lookup image name for a custom image in region if we need it
data "ibm_is_image" "rhel79" {
  name = "ibm-redhat-7-9-minimal-amd64-3"
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.ibm_ssh_key_name
}

data "ibm_is_subnet" "zone_1_subnet" {
  identifier = var.ibm_zone_1_subnet_id
}

data "ibm_is_subnet" "zone_2_subnet" {
  identifier = var.ibm_zone_2_subnet_id
}

data "ibm_is_subnet" "zone_3_subnet" {
  identifier = var.ibm_zone_3_subnet_id
}

data "ibm_is_vpc" "sat_vpc" {
  name = data.ibm_is_subnet.zone_1_subnet.vpc_name
}

locals {
  attach_script_content = base64encode(var.ibm_attach_script == "" ? "echo 'unmanaged host'\n" : var.ibm_attach_script)
}


data "template_file" "rhel_server" {
  template = file("${path.module}/rhel_server.yaml")
  vars = {
    attach_script = local.attach_script_content
  }
}

locals {
  security_group_id = var.ibm_security_group_id == "" ? data.ibm_is_vpc.sat_vpc.default_security_group : var.ibm_security_group_id
}


# zone 1 servers
resource "ibm_is_instance" "compute_server_01_instance" {
  name           = "${var.ibm_resource_prefix}-cmp-1"
  resource_group = data.ibm_resource_group.group.id
  image          = data.ibm_is_image.rhel79.id
  profile        = data.ibm_is_instance_profile.compute_profile.id
  primary_network_interface {
    name            = "internal"
    subnet          = data.ibm_is_subnet.zone_1_subnet.id
    security_groups = [local.security_group_id]
  }
  vpc                = data.ibm_is_subnet.zone_1_subnet.vpc
  zone               = data.ibm_is_subnet.zone_1_subnet.zone
  keys               = [data.ibm_is_ssh_key.ssh_key.id]
  auto_delete_volume = true
  user_data          = data.template_file.rhel_server.rendered
  timeouts {
    create = "60m"
    delete = "120m"
  }
}
# zone 2 servers
resource "ibm_is_instance" "compute_server_02_instance" {
  name           = "${var.ibm_resource_prefix}-cmp-2"
  resource_group = data.ibm_resource_group.group.id
  image          = data.ibm_is_image.rhel79.id
  profile        = data.ibm_is_instance_profile.compute_profile.id
  primary_network_interface {
    name            = "internal"
    subnet          = data.ibm_is_subnet.zone_2_subnet.id
    security_groups = [local.security_group_id]
  }
  vpc                = data.ibm_is_subnet.zone_2_subnet.vpc
  zone               = data.ibm_is_subnet.zone_2_subnet.zone
  keys               = [data.ibm_is_ssh_key.ssh_key.id]
  auto_delete_volume = true
  user_data          = data.template_file.rhel_server.rendered
  timeouts {
    create = "60m"
    delete = "120m"
  }
}
# zone 3 servers
resource "ibm_is_instance" "compute_server_03_instance" {
  name           = "${var.ibm_resource_prefix}-cmp-3"
  resource_group = data.ibm_resource_group.group.id
  image          = data.ibm_is_image.rhel79.id
  profile        = data.ibm_is_instance_profile.compute_profile.id
  primary_network_interface {
    name            = "internal"
    subnet          = data.ibm_is_subnet.zone_3_subnet.id
    security_groups = [local.security_group_id]
  }
  vpc                = data.ibm_is_subnet.zone_3_subnet.vpc
  zone               = data.ibm_is_subnet.zone_3_subnet.zone
  keys               = [data.ibm_is_ssh_key.ssh_key.id]
  auto_delete_volume = true
  user_data          = data.template_file.rhel_server.rendered
  timeouts {
    create = "60m"
    delete = "120m"
  }
}

# Sleep long enough for the hosts to attach to Satellite
resource "time_sleep" "wait_for_control_host_attach" {
  depends_on = [
    ibm_is_instance.compute_server_01_instance,
    ibm_is_instance.compute_server_02_instance,
    ibm_is_instance.compute_server_03_instance
  ]
  create_duration = var.ibm_satellite_attach_delay
}

data "ibm_satellite_location" "location" {
  location = var.ibm_satellite_location_id
  depends_on = [
    time_sleep.wait_for_control_host_attach
  ]
}
