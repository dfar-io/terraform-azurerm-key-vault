resource "azurerm_key_vault" "vault" {
  name                = "${var.name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"
  tenant_id           = "${var.tenant_id}"

  sku {
    name = "standard"
  }

  access_policy {
    tenant_id = "${var.tenant_id}"
    object_id = "${var.keyvault_admin_id}"

    key_permissions = [
      "create",
      "get",
      "list",
      "wrapKey",
      "sign",
      "verify",
      "restore",
      "unwrapKey"
    ]

    secret_permissions = [
      "get",
      "set",
      "list",
      "backup",
      "restore",
      "delete"
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  count = "${length(keys(var.vault_secrets))}"

  name         = "${element(keys(var.vault_secrets), count.index)}"
  value        = "${element(values(var.vault_secrets), count.index)}"
  key_vault_id = "${azurerm_key_vault.vault.id}"
}
