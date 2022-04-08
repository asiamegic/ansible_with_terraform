

##====================scale_machine
resource "azurerm_linux_virtual_machine_scale_set" "scale_machine" {
  name                = "scale-machine"
  admin_username      = var.username
  admin_password      = var.password
  instances           = 2
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_config
  #upgrade_mode                    = "Automatic"
  disable_password_authentication = false
  depends_on                      = [azurerm_network_security_group.rg]


  network_interface {
    name                      = "netInterface"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.rg.id
    ip_configuration {
      name                                   = "publicIP"
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool.id]
      subnet_id                              = azurerm_subnet.appnet.id
      primary                                = true

    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_monitor_autoscale_setting" "autoscale_setting" {
  location            = var.location
  name                = "autoscale_setting"
  resource_group_name = var.resource_group_name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.scale_machine.id
  depends_on          = [azurerm_resource_group.rg, azurerm_linux_virtual_machine_scale_set.scale_machine]
  profile {
    name = "AutoScale"
    capacity {
      default = 3
      maximum = 5
      minimum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.scale_machine.id
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 75
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT5M"
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
      }
      scale_action {
        cooldown  = "PT1M"
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.scale_machine.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
