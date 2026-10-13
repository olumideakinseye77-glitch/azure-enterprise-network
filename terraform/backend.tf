terraform {
  backend "azurerm" {
    resource_group_name = "rg-olu-terraform-state"
    container_name      = "tfstate"
    key                 = "enterprise-network.tfstate"
    use_cli             = true
    use_azuread_auth    = true
  }
}
