output "public_ip1" {
  value = scaleway_instance_server.web.public_ip
}

output "public_ip2" {
  value = scaleway_instance_server.web2.public_ip
}

output "loadbalancer_ip" {
  value = scaleway_lb.lb.ip_address
}