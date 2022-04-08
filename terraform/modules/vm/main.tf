resource "azurerm_linux_virtual_machine" "vm-ansible" {
  name                  = "vm-ansible"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_ansible_net_interface.id]
  size                  = "Standard_B1ls"
  admin_username        = var.username_vm_ansible
  admin_password        = var.pass_vm_ansible
  disable_password_authentication = false

    source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching       = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_network_interface" "vm_ansible_net_interface" {
  name                = "vm_ansible_net_interface-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }
}

resource "azurerm_public_ip" "public-ip" {
  name                = "public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}


