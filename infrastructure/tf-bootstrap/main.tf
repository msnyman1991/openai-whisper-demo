provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

provider "random" {}

resource "azurerm_resource_group" "this" {
  name     = "tfstate"
  location = local.region
}

resource "azurerm_storage_account" "this" {
  name                     = "terraformstatewhisper"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
