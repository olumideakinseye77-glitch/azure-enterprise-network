variable "subscription_id" {
  description = "Azure subscription used for the enterprise network."
  type        = string
  default     = "0be06fbd-8a1c-4544-8855-fcea8dfd8a76"
}

variable "location" {
  description = "Azure region used for the enterprise network."
  type        = string
  default     = "UK South"
}

variable "environment" {
  description = "Environment name used for resource naming and tagging."
  type        = string
  default     = "lab"
}

variable "project_name" {
  description = "Short project name used for naming Azure resources."
  type        = string
  default     = "enterprise-network"
}

variable "hub_vnet_cidr" {
  description = "Address space for the Hub VNet."
  type        = string
  default     = "10.10.0.0/16"
}

variable "hub_shared_subnet_cidr" {
  description = "CIDR for the shared-services subnet in the Hub VNet."
  type        = string
  default     = "10.10.1.0/24"
}

variable "hub_dns_subnet_cidr" {
  description = "CIDR for the DNS/shared name-resolution subnet in the Hub VNet."
  type        = string
  default     = "10.10.2.0/24"
}

variable "app_spoke_vnet_cidr" {
  description = "Address space for the application spoke VNet."
  type        = string
  default     = "10.20.0.0/16"
}

variable "app_subnet_cidr" {
  description = "CIDR for the application subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "app_integration_subnet_cidr" {
  description = "CIDR for the application integration subnet."
  type        = string
  default     = "10.20.2.0/24"
}

variable "data_spoke_vnet_cidr" {
  description = "Address space for the data spoke VNet."
  type        = string
  default     = "10.30.0.0/16"
}

variable "private_endpoints_subnet_cidr" {
  description = "CIDR for the private endpoint subnet."
  type        = string
  default     = "10.30.1.0/24"
}

variable "data_subnet_cidr" {
  description = "CIDR for the data subnet."
  type        = string
  default     = "10.30.2.0/24"
}


variable "ssh_public_key" {
  description = "SSH public key used by temporary lab VMs such as the hub NVA."
  type        = string
}
