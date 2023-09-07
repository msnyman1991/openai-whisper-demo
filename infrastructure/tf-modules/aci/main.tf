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

resource "azurerm_monitor_action_group" "this" {
  name                = var.whisper_monitor_actiongroup_name
  resource_group_name = azurerm_resource_group.rg.name

  short_name = var.whisper_monitor_actiongroup_short_name
  email_receiver {
    name          = var.email_receiver_name
    email_address = var.email_receiver_address
  }
}

resource "azurerm_monitor_metric_alert" "example" {
  name                = var.whisper_monitor_alert_name
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_container_group.container.id]

  # Criteria for high CPU usage
  criteria {
    metric_namespace = "Microsoft.ContainerInstance/containerGroups"
    metric_name      = "CPUUsage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  # Criteria for high memory usage
  criteria {
    metric_namespace = "Microsoft.ContainerInstance/containerGroups"
    metric_name      = "MemoryUsage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  # Criteria for low storage
  # criteria {
  #   metric_namespace = "Microsoft.ContainerInstance/containerGroups"
  #   metric_name      = "StorageUsage"
  #   aggregation      = "Average"
  #   operator         = "LessThan"
  #   threshold        = 10 # You can adjust the threshold as needed
  # }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }
}

module "azurerm_application_gateway" {
  source                              = "../azure-application-gateway"
  location                            = var.location
  private_subnet_id_ag                = var.private_subnet_id_ag
  port                                = var.port
  app_gateway_rg_name                 = var.app_gateway_rg_name
  app_gateway_public_ip_name          = var.app_gateway_public_ip_name
  app_gateway_name                    = var.app_gateway_name
  app_gateway_ip_config_name          = var.app_gateway_ip_config_name
  app_gateway_frontend_port_name      = var.app_gateway_frontend_port_name
  app_gateway_frontend_ip_config_name = var.app_gateway_frontend_ip_config_name
  container_ipv4_address              = azurerm_container_group.container.ip_address

}

resource "azurerm_container_group" "container" {
  name                = var.container_group_name_prefix
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Private"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  image_registry_credential {
    username = var.acr_username
    password = var.acr_password
    server   = var.acr_servername
  }

  container {
    name   = var.container_name_prefix
    image  = var.image
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }

  subnet_ids = [var.private_subnet_id]
}

