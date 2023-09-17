
/*
data "azurerm_key_vault_secret" "password" {
  name         = "vm-password"
  key_vault_id = var.kv-id
}
*/

resource "azurerm_windows_virtual_machine" "assmnt-win-vm" {
  name                = var.win-vm-name
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vmsize
  admin_username      = var.username
  admin_password      = data.azurerm_key_vault_secret.password.value
  network_interface_ids = [
    var.nic-win,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


resource "azurerm_virtual_machine_extension" "win-cust-script" {
  name                 = var.win-custScript-name
  virtual_machine_id   = azurerm_windows_virtual_machine.assmnt-win-vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
 {
  "fileUris": ["${var.win-custScript-fileuris}"],
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file ${var.Win-custScript-command}"
 }
SETTINGS
depends_on = [ azurerm_windows_virtual_machine.assmnt-win-vm ]
}


resource "azurerm_linux_virtual_machine" "assmnt-linux-vm" {
  name                            = var.linux-vm-name
  resource_group_name             = var.resource_group
  location                        = var.location
  size                            = var.vmsize
  admin_username                  = var.username
  admin_password                  = data.azurerm_key_vault_secret.password.value
  disable_password_authentication = "false"
  network_interface_ids = [
    var.nic-lin,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}


resource "azurerm_virtual_machine_extension" "lin-cust-script" {
  name                 = var.lin-custScript-name
  virtual_machine_id   = azurerm_linux_virtual_machine.assmnt-linux-vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode({
    "fileUris"         = ["${var.lin-custScript-fileuris}"],
    "commandToExecute" = "sh ${var.lin-custScript-command}"
    }
  )
  depends_on = [ azurerm_linux_virtual_machine.assmnt-linux-vm ]
}