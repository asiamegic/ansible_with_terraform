#Create Load Balancer
resource "azurerm_lb"  "azurerm_lb" {
  name                = "loadbalance1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "frontend_ip_configuration"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

#rules for LBalancer

resource "azurerm_lb_rule"  "azurerm_lb_rule" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.azurerm_lb.id
  name                           = "lb-rule-http"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.azurerm_lb.frontend_ip_configuration[0].name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.azurerm_lb.id
  name            = "BackEndAddressPool"
}
