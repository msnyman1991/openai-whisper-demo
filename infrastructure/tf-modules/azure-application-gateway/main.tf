resource "azurerm_resource_group" "this" {
  name     = var.app_gateway_rg_name
  location = var.location
}

resource "azurerm_public_ip" "this" {
  name                = var.app_gateway_public_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
}

resource "azurerm_application_gateway" "this" {
  name                = var.app_gateway_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 4
  }

  gateway_ip_configuration {
    name      = var.app_gateway_ip_config_name
    subnet_id = var.private_subnet_id
  }

  frontend_port {
    name = var.app_gateway_frontend_port_name
    port = var.port
  }

  frontend_ip_configuration {
    name                 = var.app_gateway_frontend_ip_config_name
    public_ip_address_id = azurerm_public_ip.this.id
  }

  http_listener {
    name                           = "HttpListener"
    frontend_ip_configuration_name = var.app_gateway_frontend_ip_config_name
    frontend_port_name             = var.app_gateway_frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "RequestRoutingRule"
    rule_type                  = "Basic"
    http_listener_name         = "HttpListener"
    backend_address_pool_name  = "BackendAddressPool"
    backend_http_settings_name = "myHttpSettings"
  }

  backend_address_pool {
    name = "BackendAddressPool"
  }

  backend_http_settings {
    name                  = "myHttpSettings"
    cookie_based_affinity = "Disabled"
    protocol              = "Http"
    port                  = var.port
  }
}
