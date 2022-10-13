
resource "libvirt_network" "hosts_net" {
  name      = var.name
  addresses = var.addresses

  dns {
    enabled = true
  }
  dhcp {
    enabled = true
  }
}


