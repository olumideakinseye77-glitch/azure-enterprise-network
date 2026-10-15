locals {
  private_storage_account_name = "stolu${substr(replace(var.subscription_id, "-", ""), 0, 12)}"
}

resource "azurerm_storage_account" "private_data" {
  name                     = local.private_storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"

  public_network_access           = "Disabled"
  allow_nested_items_to_be_public = false

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Role        = "Private-Data"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_hub" {
  name                  = "link-blob-hub"
  private_dns_zone_id   = azurerm_private_dns_zone.blob.id
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_app" {
  name                  = "link-blob-app"
  private_dns_zone_id   = azurerm_private_dns_zone.blob.id
  virtual_network_id    = azurerm_virtual_network.app_spoke.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_data" {
  name                  = "link-blob-data"
  private_dns_zone_id   = azurerm_private_dns_zone.blob.id
  virtual_network_id    = azurerm_virtual_network.data_spoke.id
  registration_enabled  = false
}

resource "azurerm_private_endpoint" "blob" {
  name                = "pe-private-blob"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "psc-private-blob"
    private_connection_resource_id = azurerm_storage_account.private_data.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "blob-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}