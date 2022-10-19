variable "cluster-name" {
  default = "cluster-context-n"
}

variable "ssh-key-private-path" {
  default = "~/.ssh/id_rsa"
}

variable "ssh-user-master-node" {
  default = "root"
}


variable "ssh-host-master-node" {
  default = "192.168.0.101"
}

variable "context-path" {

}

variable "id_dependsi" {
  default = ""
}

variable "id_kubeadm_dependsi" {}
