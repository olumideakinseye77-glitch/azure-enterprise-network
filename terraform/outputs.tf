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

output "app_spoke_vnet_name" {
  description = "Name of the application spoke VNet."
  value       = azurerm_virtual_network.app_spoke.name
}

output "data_spoke_vnet_name" {
  description = "Name of the data spoke VNet."
  value       = azurerm_virtual_network.data_spoke.name
}

output "app_spoke_address_space" {
  description = "Address space assigned to the application spoke."
  value       = azurerm_virtual_network.app_spoke.address_space
}

output "data_spoke_address_space" {
  description = "Address space assigned to the data spoke."
  value       = azurerm_virtual_network.data_spoke.address_space
}
