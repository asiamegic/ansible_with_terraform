#resource "azurerm_postgresql_flexible_server_configuration" "postgres_configuration" {
#  name       = "require_secure_transport"
#  server_id  = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
#  value      = "off"
#  depends_on = [azurerm_postgresql_flexible_server.postgresql_flexible_server]
#}


# storage_account
#resource "azurerm_storage_account" "storage-account" {
#  name                     = "storage-acc"
#  account_replication_type = "LRS"
#  account_tier             = "Standard"
#  location                 = var.location
#  resource_group_name      = var.resource_group_name
#  allow_blob_public_access = true
#}
#
#resource "azurerm_storage_container" "storage-container" {
#  name                 = "azurerm-storage-container"
#  storage_account_name = azurerm_storage_account.storage-account.name
#  container_access_type = "blob"
#}