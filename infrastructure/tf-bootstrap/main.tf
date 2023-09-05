provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

provider "random" {}

resource "random_string" "naming_convention" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_resource_group" "this" {
  name     = "tfstate-${random_string.naming_convention.result}"
  location = local.region
}

resource "azurerm_storage_account" "this" {
  name                     = "terraform${random_string.naming_convention.result}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "terraform-state-${random_string.naming_convention.result}"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
