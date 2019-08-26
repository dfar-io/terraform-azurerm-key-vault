output "vault_id" {
  value = "${azurerm_key_vault.vault.id}"
}

output "vault_name" {
  value = "${azurerm_key_vault.vault.name}"
}
