resource "scaleway_instance_ip" "server_ip" {}

resource "scaleway_instance_security_group" "www" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action   = "accept"
    port     = "22"
    ip_range = "0.0.0.0/0"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
}

resource "scaleway_instance_server" "web" {
  type = "DEV1-S"
  image = "ubuntu_jammy"
  name = "Cloud-1 server"
  ip_id = scaleway_instance_ip.server_ip.id
  security_group_id = scaleway_instance_security_group.www.id
}