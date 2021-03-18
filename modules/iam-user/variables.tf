variable "name" {
  description = "Desired name for the IAM user."
  type        = string
}

variable "path" {
  description = "Desired path for the IAM user."
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
  type        = string
  default     = ""
}

variable "groups" {
  description = "A list of IAM Groups to add the user to."
  type        = list(string)
  default     = []
}

variable "create_login_profile" {
  description = "Whether to create IAM user login profile."
  type        = bool
  default     = true
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key."
  type        = string
  default     = ""
}

variable "password_length" {
  description = "The length of the generated password"
  type        = number
  default     = 20
}

variable "password_reset_required" {
  description = "Whether the user should be forced to reset the generated password on first login."
  type        = bool
  default     = true
}

variable "create_access_key" {
  description = "Whether to create IAM access key."
  type        = bool
  default     = false
}

variable "access_key_enabled" {
  description = "Whether to activate IAM access key."
  type        = bool
  default     = true
}

variable "upload_ssh_key" {
  description = "Whether to upload a public ssh key to the IAM user."
  type        = bool
  default     = false
}

variable "ssh_public_key_encoding" {
  description = "Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM."
  type        = string
  default     = "SSH"
}

variable "ssh_public_key" {
  description = "The SSH public key. The public key must be encoded in ssh-rsa format or PEM format."
  type        = string
  default     = ""
}

variable "ssh_public_key_enabled" {
  description = "Whether to activate the SSH public key."
  type        = bool
  default     = true
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the user."
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "List of IAM policies ARNs to attach to IAM user."
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of inline IAM policies to attach to IAM user. (`name` => `policy`)."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
}

variable "resource_group_description" {
  description = "The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
}
