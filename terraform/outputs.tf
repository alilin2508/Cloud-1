output "public_ip1" {
  value = scaleway_instance_server.web.public_ip
}

output "public_ip2" {
  value = scaleway_instance_server.web2.public_ip
}

output "db_pn_ip" {
  value = scaleway_rdb_instance.main.private_network[0].ip
}

output "lb_ip" {
  value = scaleway_lb.lb.ip_address
}
