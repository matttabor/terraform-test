
variable "resource_group_name" {
  description = "name for your cluster resource group"
}

variable "location" {
  description = "e.g. australiaeast"
}

variable "acr_name" {
  description = "ACR Name"
  default = "CopperTreeTestRegistry"
}