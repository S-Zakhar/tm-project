output "instances_ip" {
  value = vkcs_networking_floatingip.fip.*.address
}

output "app_ip" {
  value = vkcs_networking_floatingip.fip-app.address
}

output "http_balancer_vip_address" {
  value = vkcs_networking_floatingip.floating_ip.address
}
