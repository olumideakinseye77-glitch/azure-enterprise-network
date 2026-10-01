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
