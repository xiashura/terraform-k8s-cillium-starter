resource "libvirt_pool" "hosts" {
  name = var.name
  type = "dir"
  path = var.path
}

