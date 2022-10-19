
resource "null_resource" "download-k8s-context" {

  triggers = {
    id_dependsi = var.id_dependsi
  }

  connection {
    type        = "ssh"
    user        = var.ssh-user-master-node
    private_key = file(var.ssh-key-private-path)
    host        = var.ssh-host-master-node
  }

  provisioner "local-exec" {
    command = <<EOF
      mkdir -p ${var.context-path}/context && \
      rsync -e "ssh -o StrictHostKeyChecking=no" -Wav --progress ${var.ssh-user-master-node}@${var.ssh-host-master-node}:/etc/kubernetes/admin.conf ${var.context-path}/context/${var.cluster-name}.yml
    EOF
  }

}
