
variable "name" {
  default = "cluster-storage-n"
}

variable "path" {
  description = "path to libvirt pool"
  default     = "/tmp/terraform_hosts"
}
