variable "resource_group" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure Region name"
}

variable "win-vm-name" {
  type        = string
  description = "Windows VM name"
}

variable "linux-vm-name" {
  type        = string
  description = "linux VM name"
}

variable "vmsize" {
  type        = string
  description = "VM Size"
}

variable "username" {
  type        = string
  description = "VM login username"
}

variable "nic-win" {
  type        = string
  description = "NIC for Windows VM"
}

variable "nic-lin" {
  type        = string
  description = "NIC for Linux VM"
}

variable "win-custScript-name" {
  type        = string
  description = "Name for Custom Script Extension for Windows VM"
}

variable "win-custScript-fileuris" {
  type        = string
  description = "fileuris for Custom Script Extension for Windows VM"
}

variable "Win-custScript-command" {
  type        = string
  description = "Command to execute Custom Script Extension for Windows VM"
}

variable "lin-custScript-name" {
  type        = string
  description = "Name for Custom Script Extension for Linux VM"
}

variable "lin-custScript-fileuris" {
  type        = string
  description = "fileuris for Custom Script Extension for linux VM"
}

variable "lin-custScript-command" {
  type        = string
  description = "Command to execute Custom Script Extension for Linux VM"
}

variable "kv-id" {
  type    = string
  default = "if for keyvault"
}