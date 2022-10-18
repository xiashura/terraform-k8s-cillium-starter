

variable "my-ssh-keys" {
  type = list(string)
  default = [
    "",
  ]
}


variable "image" {
  default = "../../build/k8s-image.qcow2"
}
