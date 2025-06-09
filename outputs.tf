output "resource_group_name" {
  description = "Resource Group Name"
  value       = azurerm_resource_group.aks_rg.name
}

output "aks_cluster_name" {
  description = "AKS Cluster Name"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_kube_config" {
  description = "Kube Config Raw"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive   = true
}