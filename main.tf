provider "azurerm" {
  features {}
  subscription_id = "04cd8690-37e9-4b37-bc1b-248f9552b2a6"  # your subscription
}

# Resource Group
resource "azurerm_resource_group" "aks_rg" {
  name     = "multi-cloud-aks-rg"
  location = "eastus"
}

# Virtual Network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "multi-cloud-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

# Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "multi-cloud-subnet"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# AKS Cluster with Fixed Default Node Pool
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "multi-cloud-aks"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "multicloudaks"

  default_node_pool {
    name           = "systempool"
    vm_size        = "Standard_B2s"
    node_count     = 1
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }
}

# Custom Node Pool with Autoscaling Enabled
resource "azurerm_kubernetes_cluster_node_pool" "autoscale_pool" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_B2s"
  mode                  = "User"                   

  auto_scaling_enabled   = true
  #min_count             = 1
  #max_count             = 3

  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
}