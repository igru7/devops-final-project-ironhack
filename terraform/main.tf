provider "azurerm" {
  subscription_id = var.subscription_id

  features {}   #  block, not argument
}

# ------------------------------
# Resource Group
# ------------------------------
resource "azurerm_resource_group" "rg" {
  name     = "irene-rg-${var.region}"
  location = var.region
}

# ------------------------------
# User-assigned identity for control plane
# ------------------------------
resource "azurerm_user_assigned_identity" "cp_mi" {
  name                = "irene-cp-mi-${var.region}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# ------------------------------
# Virtual Network & Subnet
# ------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-irene-${var.region}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}



# ------------------------------
# Role assignment: Managed Identity Operator
# ------------------------------
resource "azurerm_role_assignment" "cp_mi_mio" {
  principal_id         = azurerm_user_assigned_identity.cp_mi.principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_resource_group.rg.id
}

# ------------------------------
# AKS Cluster
# ------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-irene-${var.region}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "ireneaks${var.region}"
  kubernetes_version  = var.aks_version

  # Enable OIDC workload identity
  oidc_issuer_enabled = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.cp_mi.id]
  }

  default_node_pool {
    name           = "systempool"
    node_count     = 1
    vm_size        = var.node_vm_size
    #vnet_subnet_id = azurerm_subnet.subnet.id
  }


  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"
  }

  depends_on = [
    azurerm_role_assignment.cp_mi_mio
  ]
}

resource "azurerm_public_ip" "ingress_ip" {
  name                = "ingress-ip"
  resource_group_name = data.azurerm_resource_group.aks_managed_rg.name
  location            = azurerm_kubernetes_cluster.aks.location
  allocation_method   = "Static"
  sku                 = "Standard"
}