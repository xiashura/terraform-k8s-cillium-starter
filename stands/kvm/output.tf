output "worker-1-ip" {
  value = module.cluster-1-work-nodes[0].ip
}

output "worker-2-ip" {
  value = module.cluster-1-work-nodes[1].ip
}

output "master-ip" {
  value = module.cluster-1-master-node.ip
}
