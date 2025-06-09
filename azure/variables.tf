variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
  default     = "multi-cloud-aks-rg"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
  default     = "multi-cloud-vnet"
}

variable "vnet_address_space" {
  description = "Address space for VNet"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
  default     = "multi-cloud-subnet"
}

variable "subnet_prefix" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.1.0.0/24"
}

variable "cluster_name" {
  description = "AKS Cluster Name"
  type        = string
  default     = "multi-cloud-aks"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "multicloudaks"
}