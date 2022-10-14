variable "name" {
  description = "The name of the node"
}

variable "memory" {
  description = "The amount of memory in megabytes"
}

variable "vcpu" {
  description = "The amount of virtual CPUs"
}

variable "disk_size" {
  description = "The disk size in gigabytes"
}

variable "libvirt_pool" {
  description = "The libvirt_pool object where to create images"
}

variable "libvirt_network" {
  description = "The libvirt_network object where to network interfaces"
}

variable "image_base" {
  description = "url or path to base image system"
  default     = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

variable "ssh_key" {
  type        = list(string)
  description = "ssh key pub for cloud-init auth "
}
