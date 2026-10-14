resource "azurerm_route_table" "app" {
  name                = "rt-app-spoke"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  route {
    name                   = "route-to-data-via-hub-nva"
    address_prefix         = var.data_spoke_vnet_cidr
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.hub_nva.private_ip_address
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_route_table" "data" {
  name                = "rt-data-spoke"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  route {
    name                   = "route-to-app-via-hub-nva"
    address_prefix         = var.app_spoke_vnet_cidr
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.hub_nva.private_ip_address
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet_route_table_association" "app" {
  subnet_id      = azurerm_subnet.app.id
  route_table_id = azurerm_route_table.app.id
}

resource "azurerm_subnet_route_table_association" "data" {
  subnet_id      = azurerm_subnet.data.id
  route_table_id = azurerm_route_table.data.id
}