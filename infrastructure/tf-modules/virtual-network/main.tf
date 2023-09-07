resource "random_string" "naming_convention" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}-${random_string.naming_convention.result}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.virtual_network_name}-${random_string.naming_convention.result}"
  address_space       = var.virtual_network_cidr
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

# Private Subnets
resource "azurerm_subnet" "private" {
  name                 = "${var.private_subnet_name}-${random_string.naming_convention.result}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.private_address_prefixes

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet" "private_ag" {
  name                 = "${var.private_subnet_name}-ag-${random_string.naming_convention.result}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.private_address_prefixes_ag
}
