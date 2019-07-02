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

variable "cluster_name" {
  description = "name for your cluster"
}

variable "kubernetes_version" {
  description = "version number."
}

variable "env_tag" {
  description = "whatever you want here"
}

variable "dns_prefix" {
  description = "DNS prefix"
}

variable "node_pool_name" {
  description = "The name of the node pool"
  default = "nodes"
}

variable "node_pool_size" {
  description = "The amount of nodes in the cluster"
}

variable "node_pool_vmsize" {
  description = "The vmsize for the nodes"
}

variable "node_pool_os" {
  description = "The os for the nodes"
  default = "Linux"
}