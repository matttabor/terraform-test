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

resource "azurerm_kubernetes_cluster" "k8s" {
    name                    = "AKS-${terraform.workspace}"
    kubernetes_version      = "${var.kubernetes_version}"
    location                = "${azurerm_resource_group.aks.location}"
    resource_group_name     = "${azurerm_resource_group.aks.name}"
    dns_prefix              = "AKS-${var.dns_prefix}"

    agent_pool_profile {
        name                = "${var.node_pool_name}"
        count               = "${var.node_pool_size}"
        vm_size             = "${var.node_pool_vmsize}"
        os_type             = "${var.node_pool_os}"
        os_disk_size_gb     = 30
    }
    
    service_principal {
        client_id           = "${var.client_id}"
        client_secret       = "${var.client_secret}"
    }

    tags = {
        environment = "${var.env_tag}"
    }
}