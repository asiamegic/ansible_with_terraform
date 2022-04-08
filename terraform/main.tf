#virtual machine module for ansible
module "vm_ansible" {
  source              = "./modules/vm"

  resource_group_name = var.resource_group_name
  location            = var.location
  username_vm_ansible  = var.username
  pass_vm_ansible      = var.password
  subnet_id           = azurerm_subnet.appnet.id

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

