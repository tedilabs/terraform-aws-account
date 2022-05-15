variable "name" {
  description = "(Required) Desired name for the IAM user."
  type        = string
}

variable "path" {
  description = "(Optional) Desired path for the IAM user."
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "(Optional) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}

variable "permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the user."
  type        = string
  default     = null
}

variable "groups" {
  description = "(Optional) A list of IAM Groups to add the user to."
  type        = list(string)
  default     = []
}

variable "pgp_key" {
  description = "(Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key."
  type        = string
  default     = ""
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
  description = "(Optional) List of IAM roles ARNs which can be assumed by the user."
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "(Optional) List of IAM policies ARNs to attach to IAM user."
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "(Optional) Map of inline IAM policies to attach to IAM user. (`name` => `policy`)."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
}
