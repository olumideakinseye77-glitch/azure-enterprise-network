resource "azurerm_resource_group" "main" {
  name     = "rg-olu-enterprise-network"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
