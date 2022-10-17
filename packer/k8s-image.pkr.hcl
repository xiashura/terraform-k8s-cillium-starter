

packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.4"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "cloud_init_image" {
  type    = string
  default = "./tmp/cloud-init.img"
}

variable "cpus" {
  type    = string
  default = "4"
}

variable "disk_size" {
  type    = string
  default = "8192"
}

variable "image_checksum" {
  type    = string
  default = "0f429a529350d750c4769f73d71ceaf492b81f4cf8c9c03d9821673c5829765d"
}

variable "image_checksum_type" {
  type    = string
  default = "sha256"
}

variable "image_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img"
}

variable "memory" {
  type    = string
  default = "4096M"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "ssh_private_key_file" {
  type = string
  default = "~/.ssh/id_rsa"
}

locals {
  vm_name = "k8s-image.qcow2"
}

source "qemu" "k8s-image" {
  accelerator         = "kvm"
  boot_command        = ["<enter>"]
  disk_compression    = true
  disk_image          = true
  disk_size           = "${var.disk_size}"
  format              = "qcow2"
  headless            = true
  iso_checksum        = "${var.image_checksum}"
  iso_url             = "${var.image_url}"
  output_directory    = "build"
  qemuargs            = [["-m", "${var.memory}"], ["-smp", "cpus=${var.cpus}"], ["-cdrom", "${var.cloud_init_image}"], ["-serial", "mon:stdio"]]
  ssh_port            = 22
  ssh_username        = "${var.ssh_username}"
  ssh_private_key_file = "${var.ssh_private_key_file}"
  ssh_wait_timeout    = "300s"
  use_default_display = false
  vm_name             = "${local.vm_name}"
}

build {
  sources = ["source.qemu.k8s-image"]

  provisioner "shell" {
    execute_command = "bash -x {{.Path}}"
    scripts = [
      "./cloud-init/scripts/install-k8s.sh"
    ]
  }
}
