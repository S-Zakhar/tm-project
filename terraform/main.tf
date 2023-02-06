data "vkcs_compute_flavor" "compute" {
  name = var.flavor_id
}

data "vkcs_images_image" "compute" {
  name = var.image_id
}

resource "vkcs_compute_instance" "instance" {
  name              = format("%s-%02d", "instance", count.index + 1)
  count             = var.instances_count
  flavor_id         = data.vkcs_compute_flavor.compute.id
  security_groups   = ["all","default"]
  availability_zone = "GZ1"
  user_data         = var.our-keys

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-hdd"
    volume_size           = 20
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    access_network = true
    uuid = vkcs_networking_network.compute.id
  }
  
  depends_on = [
  vkcs_networking_network.compute,
  vkcs_networking_subnet.compute
  ]
}


resource "vkcs_compute_instance" "app" {
  name              = "app"
  # count             = var.instances_count
  flavor_id         = data.vkcs_compute_flavor.compute.id
  security_groups   = ["all","default"]
  availability_zone = "MS1"
  user_data         = var.our-keys

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-hdd"
    volume_size           = 20
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    access_network = true
    uuid = vkcs_networking_network.compute.id
  }
  
  depends_on = [
  vkcs_networking_network.compute,
  vkcs_networking_subnet.compute
  ]
}
