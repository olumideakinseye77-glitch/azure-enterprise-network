output "resource_group_name" {
  description = "Name of the resource group hosting the enterprise network."
  value       = azurerm_resource_group.main.name
}

output "hub_vnet_name" {
  description = "Name of the Hub VNet."
  value       = azurerm_virtual_network.hub.name
}

output "hub_vnet_id" {
  description = "Resource ID of the Hub VNet."
  value       = azurerm_virtual_network.hub.id
}

output "hub_address_space" {
  description = "Address space assigned to the Hub VNet."
  value       = azurerm_virtual_network.hub.address_space
}
