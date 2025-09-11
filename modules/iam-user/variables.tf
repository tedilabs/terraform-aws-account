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
  (Optional) A configuration of the AWS console access and password for the user. `console_access` as defined below.
    (Optional) `enabled` - Whether to activate the AWS console access and password. Defaults to `true`.
    (Optional) `password_length` - The length of the generated password. Only applies on resource creation. Defaults to `20`.
    (Optional) `password_reset_required` -  Whether the user should be forced to reset the generated password on first login. Defaults to `true`.
  EOF
  type = object({
    enabled                 = optional(bool, true)
    password_length         = optional(number, 20)
    password_reset_required = optional(bool, true)
  })
  default  = {}
  nullable = false
}

variable "access_keys" {
  description = <<EOF
  (Optional) A list of Access Keys to associate with the IAM user. This is a set of credentials that allow API requests to be made as an IAM user. The IAM User can have a maximum of two Access Keys (active or inactive) at a time. Each item of `access_keys` as defined below.
    (Optional) `enabled` - Whether to activate the Access Key. Defaults to `true`.
  EOF
  type = list(object({
    enabled = optional(bool, true)
  }))
  default  = []
  nullable = false

  validation {
    condition     = length(var.access_keys) <= 2
    error_message = "The IAM User can have a maximum of two Access Keys (active or inactive) at a time."
  }
}

variable "ssh_keys" {
  description = <<EOF
  (Optional) A list of SSH public keys to associate with the IAM user. can have a maximum of five SSH public keys (active or inactive) at a time. Each item of `ssh_keys` as defined below.
    (Optional) `enabled` - Whether to activate the SSH public key. Defaults to `true`.
    (Required) `public_key` - The SSH public key. The public key must be encoded in ssh-rsa format or PEM format.
    (Optional) `encoding` - Specify the public key encoding format. Valid values are `SSH` and `PEM`. To retrieve the public key in ssh-rsa format, use `SSH`. To retrieve the public key in PEM format, use `PEM`.
  EOF
  type = list(object({
    enabled    = optional(bool, true)
    public_key = string
    encoding   = optional(string, "SSH")
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for ssh_key in var.ssh_keys : contains(["SSH", "PEM"], ssh_key.encoding)
    ])
    error_message = "Valid values for `encoding` are `SSH` and `PEM`."
  }
  validation {
    condition     = length(var.ssh_keys) <= 5
    error_message = "The IAM User can have a maximum of five SSH public keys (active or inactive) at a time."
  }
}

variable "service_credentials" {
  description = <<EOF
  (Optional) A list of service specific credentials to associate with the IAM user. Each value of `service_credentials` block as defined below.
    (Required) `service` - The name of the AWS service that is to be associated with the credentials. The service you specify here is the only service that can be accessed using these credentials.
    (Optional) `enabled` - Whether to activate the service specific credential. Defaults to `true`.
  EOF
  type = list(object({
    service = string
    enabled = optional(bool, true)
  }))
  default  = []
  nullable = false
}

variable "signing_certificates" {
  description = <<EOF
  (Optional) A list of X.509 signing certificates to associate with the IAM user. Each item of `signing_certificates` as defined below.
    (Optional) `enabled` - Whether to activate the signing certificate. Defaults to `true`.
    (Required) `certificate` - The contents of the signing certificate in PEM encoded format.
  EOF
  type = list(object({
    enabled          = optional(bool, true)
    certificate_body = string
  }))
  default  = []
  nullable = false
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

variable "exclusive_inline_policy_management_enabled" {
  description = "(Optional) Whether to enable exclusive management for inline IAM policies of the IAM user. This includes removal of inline IAM policies which are not explicitly configured. Defaults to `false`."
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
  description = "(Optional) A map of inline IAM policies to attach to IAM user. The policy is a JSON document that you attach to an identity to specify what API actions you're allowing or denying for that identity, and under which conditions. Each key is the name of the policy, and the value is the policy document."
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

variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
