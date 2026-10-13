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
