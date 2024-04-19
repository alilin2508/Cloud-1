resource "scaleway_lb_ip" "lb_ip" {}

resource "scaleway_lb" "lb" {
  ip_id   = scaleway_lb_ip.lb_ip.id
  type    = "LB-S"
  name    = "inception's lb"
}

resource "scaleway_lb_backend" "lb_out" {
  lb_id            = scaleway_lb.lb.id
  name             = "inception's lb backend"
  forward_protocol = "http"
  forward_port     = "443"
  ignore_ssl_server_verify = true
  server_ips = [scaleway_instance_server.web.public_ip, scaleway_instance_server.web2.public_ip]
}

resource "scaleway_lb_certificate" "cert" {
  lb_id = scaleway_lb.lb.id
  name = "test-cert-front-end"
  letsencrypt {
    common_name = "${replace(scaleway_lb_ip.lb_ip.ip_address,".", "-")}.lb.${scaleway_lb.lb.region}.scw.cloud"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_lb_frontend" "lb_in" {
  lb_id        = scaleway_lb.lb.id
  backend_id   = scaleway_lb_backend.lb_out.id
  name         = "inception's lb frontend"
  inbound_port = "443"
  certificate_ids = [scaleway_lb_certificate.cert.id]
}