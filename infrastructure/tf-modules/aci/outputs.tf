output "container_ipv4_address" {
  value = azurerm_container_group.container.ip_address
}

output "fqdn" {
  value = azurerm_container_group.container.fqdn
}

 