resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}

# resource "random_string" "container_name" {
#   length  = 25
#   lower   = true
#   upper   = false
#   special = false
# }

resource "azurerm_container_group" "container" {
  name                = var.container_group_name_prefix
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  image_registry_credential {
    username = var.acr_username
    password = var.acr_password
    server   = var.acr_servername
  }

  dynamic "container" {
    for_each = var.containers # Specify the number of containers you want
    content {
      name   = "container-${container.key}"
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      dynamic "ports" {
        for_each = container.value.ports
        iterator = p

        content {
          port     = p.value.port
          protocol = p.value.protocol
        }
      }
    }
  }
}



