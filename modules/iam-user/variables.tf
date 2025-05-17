variable "name" {
  description = "(Required) Desired name for the IAM user."
  type        = string
  nullable    = false
}

variable "path" {
  description = "(Optional) Desired path for the IAM user. Defaults to `/`."
  type        = string
  default     = "/"
  nullable    = false
}

variable "force_destroy" {
  description = "(Optional) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the user."
  type        = string
  default     = null
  nullable    = true
}

variable "groups" {
  description = "(Optional) A set of IAM Groups to add the user to."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "pgp_key" {
  description = "(Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key."
  type        = string
  default     = ""
  nullable    = false
}

variable "console_access" {
  description = <<EOF
  (Optional) The configuration of the AWS console access and password for the user. `console_access` block as defined below.
    (Optional) `enabled` - Whether to activate the AWS console access and password.
    (Optional) `password_length` - The length of the generated password. Only applies on resource creation. Default value is `20`.
    (Optional) `password_reset_required` -  Whether the user should be forced to reset the generated password on first login. Defaults to `true`.
  EOF
  type        = any
  default     = {}
}

variable "access_keys" {
  description = <<EOF
  (Optional) A list of Access Keys to associate with the IAM user. This is a set of credentials that allow API requests to be made as an IAM user. Each value of `access_keys` block as defined below.
    (Required) `enabled` - Whether to activate the Access Key.
  EOF
  type        = list(map(bool))
  default     = []
}

variable "ssh_keys" {
  description = <<EOF
  (Optional) A list of SSH public keys to associate with the IAM user. Each value of `ssh_keys` block as defined below.
    (Required) `public_key` - The SSH public key. The public key must be encoded in ssh-rsa format or PEM format.
    (Optional) `encoding` - Specify the public key encoding format. Valid values are `SSH` and `PEM`. To retrieve the public key in ssh-rsa format, use `SSH`. To retrieve the public key in PEM format, use `PEM`.
    (Optional) `enabled` - Whether to activate the SSH public key.
  EOF
  type        = any
  default     = []
}

variable "service_credentials" {
  description = <<EOF
  (Optional) A list of service specific credentials to associate with the IAM user. Each value of `service_credentials` block as defined below.
    (Required) `service` - The name of the AWS service that is to be associated with the credentials. The service you specify here is the only service that can be accessed using these credentials.
    (Optional) `enabled` - Whether to activate the service specific credential.
  EOF
  type        = any
  default     = []
}

variable "assumable_roles" {
  description = "(Optional) A set of IAM roles ARNs which can be assumed by the user."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "exclusive_policy_management_enabled" {
  description = "(Optional) Whether to enable exclusive management for managed IAM policies of the IAM user. This includes removal of managed IAM policies which are not explicitly configured. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "policies" {
  description = "(Optional) A set of IAM policies ARNs to attach to IAM user."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "inline_policies" {
  description = "(Optional) A map of inline IAM policies to attach to IAM user. The policy is a JSON document that you attach to an identity to specify what API actions you're allowing or denying for that identity, and under which conditions. Each key is the name of the policy, and the value is the policy document. If `exclusive_policy_management_enabled` is `true`, this variable is ignored."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
