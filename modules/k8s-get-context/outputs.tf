
output "id_dependsi" {
  value = null_resource.download-k8s-context.triggers.id_dependsi
}

output "path" {
  value = "${var.context-path}/context/${var.cluster-name}.yml"
}
