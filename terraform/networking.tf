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

resource "azurerm_virtual_network" "app_spoke" {
  name                = "vnet-app-spoke"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.app_spoke_vnet_cidr]

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Role        = "App-Spoke"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.app_spoke.name
  address_prefixes     = [var.app_subnet_cidr]
}

resource "azurerm_subnet" "app_integration" {
  name                 = "snet-integration"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.app_spoke.name
  address_prefixes     = [var.app_integration_subnet_cidr]
}

resource "azurerm_virtual_network" "data_spoke" {
  name                = "vnet-data-spoke"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.data_spoke_vnet_cidr]

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Role        = "Data-Spoke"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = "snet-private-endpoints"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.data_spoke.name
  address_prefixes     = [var.private_endpoints_subnet_cidr]
}

resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.data_spoke.name
  address_prefixes     = [var.data_subnet_cidr]
}
