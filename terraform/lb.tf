resource "vkcs_networking_floatingip" "floating_ip" {
  pool    = "ext-net"
  port_id = vkcs_lb_loadbalancer.http_balancer.vip_port_id
}

resource "vkcs_lb_loadbalancer" "http_balancer" {
  name          = "http_balancer"
  description   = "An HTTP load balancer in a private network with 2 backends"
  vip_subnet_id = vkcs_networking_subnet.compute.id
}

resource "vkcs_lb_listener" "http_listener" {
  name            = "http_listener"
  description     = "A load balancer frontend that listens on 80 prot for client traffic"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = vkcs_lb_loadbalancer.http_balancer.id
}

resource "vkcs_lb_pool" "http_pool" {
  name        = "http_pool"
  description = "A load balancer pool of backends with Round-Robin algorithm to distribute traffic to pool's members"
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = vkcs_lb_listener.http_listener.id
}

resource "vkcs_lb_monitor" http_monitor {
  name           = "http_monitor"
  delay          = 5
  max_retries    = 3
  timeout        = 4
  type           = "HTTP"
  url_path       = "/"
  http_method    = "GET"
  expected_codes = "200"
  pool_id        = vkcs_lb_pool.http_pool.id
}

resource "vkcs_lb_member" "member_1" {
  address = vkcs_networking_floatingip.fip[0].fixed_ip
  protocol_port = 80
  pool_id = vkcs_lb_pool.http_pool.id
  subnet_id = vkcs_networking_subnet.compute.id
  weight = 10
  lifecycle {
    create_before_destroy = true
  }  
}

resource "vkcs_lb_member" "member_2" {
  address = vkcs_networking_floatingip.fip-app.fixed_ip
  protocol_port = 80
  pool_id = vkcs_lb_pool.http_pool.id
  subnet_id = vkcs_networking_subnet.compute.id
  weight = 10
  lifecycle {
    create_before_destroy = true
  }
}