variable "name" {}
variable "rg_name" {}
variable "rg_location" {}
variable "vault_secrets" {
  default = {}
}
variable "tenant_id" {}
variable "access_policy" {
  description = "Key Vault access policies."
  type = list(object({
    tenant_id          = string
    object_id          = string
    key_permissions    = list(string)
    secret_permissions = list(string)
    certificate_permissions = list(string)
  }))
  default = []
}
