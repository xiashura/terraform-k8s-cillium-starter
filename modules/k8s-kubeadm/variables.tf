
variable "name-cluster" {
  default = "cluster-n"
}

variable "ssh-key-private-path" {
  default = "~/.ssh/id_rsa"
}

variable "master-node" {
  default = {
    user = "root",
    ip   = "192.186.0.1",
  }
}


variable "worker-nodes" {
  type = list(object({
    user = string,
    ip   = string,
    })
  )
}

variable "id_dependsi" {
  default = ""
}
