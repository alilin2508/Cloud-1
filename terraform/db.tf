variable "MYSQL_USER" {
}

variable "MYSQL_PASSWORD" {
}

resource "scaleway_vpc_private_network" "pn" {
  region = "fr-par"
  ipv4_subnet {
    subnet = "172.16.64.0/22"
  }
}

resource "scaleway_rdb_instance" "main" {
  name               = "inceptionalice"
  node_type          = "db-play2-nano"
  engine             = "MySQL-8"
  is_ha_cluster      = false
  disable_backup     = true
  user_name          = var.MYSQL_USER
  password           = var.MYSQL_PASSWORD
  region             = "fr-par"
  private_network {
    pn_id  = scaleway_vpc_private_network.pn.id
    ip_net = "172.16.64.10/22"
  }
  volume_type        = "sbs_5k"
  volume_size_in_gb  = 5
}

