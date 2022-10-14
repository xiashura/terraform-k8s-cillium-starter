

output "ip" {
  value = libvirt_domain.kvm_node.network_interface.*.addresses
}


output "kvm_id" {
  value = libvirt_domain.kvm_node.id
}
