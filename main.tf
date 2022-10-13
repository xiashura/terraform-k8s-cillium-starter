module "libvirt-network-cluster-1" {
  source = "./modules/kvm-vm-network"

  name      = "cluster-1"
  addresses = ["10.221.1.0/24"]

  providers = {
    libvirt = libvirt.remote
  }
}

module "libvirt-storage-pool" {
  source = "./modules/kvm-vm-storage"

  name = "clusters"
  path = "/tmp/terraform/clusters"

  providers = {
    libvirt = libvirt.remote
  }
}
