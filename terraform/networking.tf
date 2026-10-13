resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.hub_vnet_cidr]

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Role        = "Hub"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "hub_shared" {
  name                 = "snet-shared"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_shared_subnet_cidr]
}

resource "azurerm_subnet" "hub_dns" {
  name                 = "snet-dns"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_dns_subnet_cidr]
}
