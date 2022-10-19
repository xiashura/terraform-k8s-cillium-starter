
resource "null_resource" "init-master-node" {

  connection {
    type        = "ssh"
    user        = var.master-node.user
    private_key = file(var.ssh-key-private-path)
    host        = var.master-node.ip
  }

  provisioner "remote-exec" {
    inline = [
      "kubeadm init",
      "mkdir -p $HOME/.kube",
      "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config",
      "sudo chown $(id -u):$(id -g) $HOME/.kube/config",
    ]
  }

  provisioner "local-exec" {
    command = <<EOF
      TOKEN=$(ssh -o StrictHostKeyChecking=no ${var.master-node.user}@${var.master-node.ip} sudo kubeadm token list | tail -1 | cut -f 1 -d " ") 
      HASH=$(ssh -o StrictHostKeyChecking=no ${var.master-node.user}@${var.master-node.ip} openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //' ) 
      echo "kubeadm join ${var.master-node.ip}:6443 --token $TOKEN --discovery-token-ca-cert-hash sha256:$HASH" > ${path.root}/tmp/script-worker-join-${var.name-cluster}.sh
    EOF
  }

}


resource "null_resource" "join-worker-nodes" {


  depends_on = [
    null_resource.init-master-node
  ]

  count = length(var.worker-nodes)

  connection {
    type        = "ssh"
    user        = var.worker-nodes[count.index].user
    private_key = file(var.ssh-key-private-path)
    host        = var.worker-nodes[count.index].ip
  }

  provisioner "file" {
    source      = "${path.root}/tmp/script-worker-join-${var.name-cluster}.sh"
    destination = "/root/script-worker-join-${var.name-cluster}.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /root/script-worker-join-${var.name-cluster}.sh"
    ]
  }


}

resource "null_resource" "vitality_check" {

  triggers = {
    id_dependsi = var.id_dependsi
  }

  depends_on = [
    null_resource.join-worker-nodes
  ]


  connection {
    type        = "ssh"
    user        = var.master-node.user
    private_key = file(var.ssh-key-private-path)
    host        = var.master-node.ip
  }

  provisioner "remote-exec" {
    inline = [
      "kubectl get nodes",
    ]
  }

}
