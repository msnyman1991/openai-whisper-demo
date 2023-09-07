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
}

# Public Subnets
# resource "azurerm_subnet" "public" {
#   name                 = "${var.public_subnet_name}-${random_string.naming_convention.result}"
#   resource_group_name  = azurerm_resource_group.this.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = var.public_address_prefixes
# }

# resource "azurerm_network_security_group" "public_nsg" {
#   name                = "public-nsg-${random_string.naming_convention.result}"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name
# }

# resource "azurerm_network_security_rule" "allow_http" {
#   name                        = "http"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "80"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.this.name
#   network_security_group_name = azurerm_network_security_group.public_nsg.name
# }

# resource "azurerm_subnet_network_security_group_association" "public_nsg_association" {
#   subnet_id                 = azurerm_subnet.public.id
#   network_security_group_id = azurerm_network_security_group.public_nsg.id
# }
