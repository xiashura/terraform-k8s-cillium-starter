variable "name" {
  type        = string
  description = "name network libvirt"
  default     = "cluster-n"
}

variable "addresses" {
  default = ["10.223.1.0/24"]
}
