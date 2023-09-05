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

resource "azurerm_container_registry" "this" {
  name                = "${var.container-registry-name}${random_string.naming_convention.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  sku                 = "Standard"
}
