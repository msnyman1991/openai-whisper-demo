resource "azurerm_resource_group" "this" {
  name     = var.lb_resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "lb_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = var.loadbalancer_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.lb_frontend_name
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "container-group-health-probe"
  protocol            = "TCP"
  port                = var.port
  interval_in_seconds = 15
  number_of_probes    = 2
  request_path        = "/"
  # request_path_behavior = "GET"
  # backend_port          = var.port
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.lb_backend_pool_name
}

resource "azurerm_lb_rule" "lb_rule" {
  name                         = var.loadbalancer_rule
  resource_group_name          = azurerm_resource_group.this.name
  loadbalancer_id              = azurerm_lb.lb.id
  frontend_ip_configuration_id = azurerm_lb.lb.frontend_ip_configuration[0].id
  backend_address_pool_id      = azurerm_lb.lb.backend_address_pool[0].id
  protocol                     = "Tcp"
  frontend_port                = var.port
  backend_port                 = var.port
  probe_id                     = azurerm_lb_probe.this.id
}