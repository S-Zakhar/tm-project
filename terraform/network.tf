data "vkcs_networking_network" "extnet" {
  name = "ext-net"
}

resource "vkcs_networking_network" "compute" {
  name = "compute-net"
}

resource "vkcs_networking_subnet" "compute" {
  name       = "subnet_1"
  network_id = vkcs_networking_network.compute.id
  cidr       = "192.168.199.0/24"
}

resource "vkcs_networking_router" "compute" {
  name                = "db-router"
  admin_state_up      = true
  external_network_id = data.vkcs_networking_network.extnet.id
}

resource "vkcs_networking_router_interface" "compute" {
  router_id = vkcs_networking_router.compute.id
  subnet_id = vkcs_networking_subnet.compute.id
}

resource "vkcs_networking_floatingip" "fip" {
  count=var.instances_count
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_compute_floatingip_associate" "fip" {
  count       = var.instances_count
  floating_ip = vkcs_networking_floatingip.fip[count.index].address
  instance_id = vkcs_compute_instance.instance[count.index].id
}

resource "vkcs_networking_floatingip" "fip-app" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_compute_floatingip_associate" "fip-app" {
  floating_ip = vkcs_networking_floatingip.fip-app.address
  instance_id = vkcs_compute_instance.app.id
}