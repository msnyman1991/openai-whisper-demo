# output "container_ipv4_addresses" {
#   value = [for container in azurerm_container_group.container : container.ip_address]
# }