# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm-1" {
  count                 = 3 # Define the VM count
  name                  = "vm-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_F2"
  admin_username        = "tfadmin"
  network_interface_ids = [azurerm_network_interface.nic-1[count.index].id]

  admin_ssh_key {
    username   = "tfadmin"
    public_key = file("/home/ubuntu/.ssh/tf-azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

