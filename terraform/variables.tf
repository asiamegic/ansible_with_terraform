#resource group name must be chosen to deploy the correct environment
variable "resource_group_name" {
  default = "production"
  #default = "staging"
}

#resource size for virtual machine
variable "vm_config" {
  type        = string
  default    = "Standard_b2s"
 #default    = "Standard_b1s"
}

#domain zones for the database
variable "azurerm_private_dns_zone" {
  type        = string
  default    = "production.private.dns-zone.postgres.database.azure.com"
  #default    = "staging.privatednszone.postgres.database.azure.com"

}

#domain zones for the database
variable "azurerm_private_dns_zone_virtual_network_link" {
  type        = string
  default    = "production.dnsvnet.com"
  #default    = "staging.dnsvnet.com"

}

#=====


variable "location" {
  type        = string
  default = "eastus"
  description = "location"
}

variable "webAppPrefix" {
  type        = string
  default = "bootcamp"

}


variable "vnet" {
  type        = string
  default = "10.0.0.0/16"

}

variable "username" {
  type        = string
  default    = ""

}

variable "azurerm_subnet" {
  type        = string
  default    = "appnet"

}


variable "password" {
  type        = string
  default    = ""

}

variable "postgresusername" {
  type        = string
  default    = ""

}
variable "postgrespassword" {
  type        = string
  default    = ""

}





