resource "azurerm_private_dns_zone" "private_dns" {
  name                = "artemproduction.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "dns-link" {
  name                  = "production-vnet-zone-link.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
resource "azurerm_postgresql_flexible_server" "postgres-flexible-server" {
  location               = var.location
  name                   = "production-postgres-flex-server"
  resource_group_name    = var.resource_group_name
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.postgresnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns.id
  administrator_login    = "yes"
  administrator_password = var.postgrespassword
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  zone                   = "1"
  depends_on             = [azurerm_private_dns_zone_virtual_network_link.dns-link]
}
resource "azurerm_postgresql_flexible_server_configuration" "postgres_config" {
  name       = "require_secure_transport"
  server_id  = azurerm_postgresql_flexible_server.postgres-flexible-server.id
  value      = "off"
}