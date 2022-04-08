#Create NSG
resource "azurerm_network_security_group" "rg" {
  name                = "my_nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                                       = "allow_to_app"
    priority                                   = 102
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    source_address_prefix                      = "*"
    destination_port_range                     = "8080"
    destination_address_prefix                 = azurerm_subnet.appnet.address_prefixes[0]
  }

  security_rule {
    name                                       = "allow_admin_app"
    priority                                   = 104
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    source_address_prefix                      = "77.137.68.50"
    destination_address_prefix = azurerm_subnet.appnet.address_prefixes[0]
    destination_port_ranges                    = ["22"]
  }

    security_rule {
    name                                       = "allow_admin_postgres"
    priority                                   = 105
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    source_address_prefix                      = azurerm_subnet.appnet.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.postgresnet.address_prefixes[0]
    destination_port_ranges                    = ["22"]
  }

    security_rule {
    name                                       = "allow_db_local"
    priority                                   = 101
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
      source_address_prefix                      = azurerm_subnet.appnet.address_prefixes[0]
    destination_port_ranges                    = ["5432"]
    destination_address_prefix = azurerm_subnet.postgresnet.address_prefixes[0]
  }

}

#association NSG
resource "azurerm_subnet_network_security_group_association" "association_app" {
  subnet_id                 = azurerm_subnet.appnet.id
  network_security_group_id = azurerm_network_security_group.rg.id
}

resource "azurerm_subnet_network_security_group_association" "association_db" {
  subnet_id                 = azurerm_subnet.postgresnet.id
  network_security_group_id = azurerm_network_security_group.rg.id
}