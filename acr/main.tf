variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

provider "azurerm" {
    version         = "=1.28.0"
    tenant_id       = "${var.tenant_id}"
    subscription_id = "${var.subscription_id}"
}

resource "azurerm_resource_group" "aks" {
    name        = "${var.resource_group_name}"
    location    = "${var.location}"
}

resource "azurerm_container_registry" "acr" {
    name                    = "${var.acr_name}"
    resource_group_name     = "${azurerm_resource_group.aks.name}"
    location                = "${azurerm_resource_group.aks.location}"
    sku                     = "Basic"
    admin_enabled           = true
}