output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = azurerm_subnet.private.id
}

output "private_subnet_id_ag" {
  description = "The ID of the private subnet"
  value       = azurerm_subnet.private_ag.id
}