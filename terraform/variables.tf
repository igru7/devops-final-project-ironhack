variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  default     = "f71e57a8-1bec-4f66-9f47-b0d4e4e77225"  # subscription ID irene
  #default     = "daf9c53c-7096-4293-9bb1-f7ad8263db1a"  # subscription ID ironhack
}

variable "region" {
  type        = string
  description = "Azure region for deployment"
  default     = "eastus"
}

variable "node_vm_size" {
  type        = string
  description = "VM size for the AKS node pool (vCPU & memory)"
  default     = "Standard_DC2ads_v5"
}

variable "node_count" {
  type        = number
  description = "Initial number of nodes in the AKS node pool"
  default     = 2
}

variable "nodepool_zones" {
  type        = list(string)
  description = "Availability zones for the AKS node pool"
  default     = ["1"]  # default to zone 1
}

variable "aks_version" {
  type        = string
  description = "Kubernetes version for the AKS cluster"
  default     = "1.32.9"
}
