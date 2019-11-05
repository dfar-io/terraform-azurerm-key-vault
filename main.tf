resource "azurerm_key_vault" "vault" {
  name                = "${var.name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"
  tenant_id           = "${var.tenant_id}"

  sku {
    name = "standard"
  }

  dynamic "access_policy" {
    for_each = "${var.access_policy}"
    content {
      tenant_id          = "${access_policy.value.tenant_id}"
      object_id          = "${access_policy.value.object_id}"
      key_permissions    = "${access_policy.value.key_permissions}"
      secret_permissions = "${access_policy.value.secret_permissions}"
      certificate_permissions = "${access_policy.value.certificate_permissions}"
    }
  }
}

resource "azurerm_key_vault_secret" "secret" {
  count = "${length(keys(var.vault_secrets))}"

  name         = "${element(keys(var.vault_secrets), count.index)}"
  value        = "${element(values(var.vault_secrets), count.index)}"
  key_vault_id = "${azurerm_key_vault.vault.id}"
}
