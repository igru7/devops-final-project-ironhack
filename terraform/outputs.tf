output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "nodepool_vm_size" {
  value = azurerm_kubernetes_cluster.aks.default_node_pool[0].vm_size
}

output "nodepool_node_count" {
  value = azurerm_kubernetes_cluster.aks.default_node_pool[0].node_count
}

output "aks_cp_identity_id" {
  value = azurerm_user_assigned_identity.cp_mi.id
}

output "ingress_public_ip" {
  description = "Public IP of the NGINX Ingress Controller"
  value       = azurerm_public_ip.ingress_ip.ip_address
}