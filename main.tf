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

module "cluster-1-master-node" {
  source = "./modules/kvm-vm-instance"

  name = "master-node"

  memory    = 2048
  vcpu      = 2
  disk_size = 30

  libvirt_pool    = module.libvirt-storage-pool.libvirt_pool
  libvirt_network = module.libvirt-network-cluster-1.libvirt_network

  image_base = var.image
  ssh_key    = [var.my-ssh-key]

  providers = {
    libvirt = libvirt.remote
  }
}

module "cluster-1-work-nodes" {
  source = "./modules/kvm-vm-instance"

  name = "worker-node-${count.index}"

  count = 2

  memory    = 2048
  vcpu      = 1
  disk_size = 20

  libvirt_pool    = module.libvirt-storage-pool.libvirt_pool
  libvirt_network = module.libvirt-network-cluster-1.libvirt_network

  image_base = var.image
  ssh_key    = [var.my-ssh-key]

  providers = {
    libvirt = libvirt.remote
  }
}
