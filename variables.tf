

variable "my-ssh-key" {
  type    = string
  default = "you ssh pub key"
}


variable "image" {
  default = "./build/master-node/master-node.qcow2"

}
