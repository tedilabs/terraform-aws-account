variable "url" {
  description = "(Required) The secure OpenID Connect URL for authentication requests. Correspond to the `iss` claim. Maximum 255 characters. URL must begin with `https://`."
  type        = string

  validation {
    condition     = startswith(var.url, "https://")
    error_message = "The value of `url` must bigin with `https://`."
  }
}

variable "audiences" {
  description = "(Optional) A list of audiences (also known as client IDs) for the IAM OIDC provider. When a mobile or web app registers with an OpenID Connect provider, they establish a value that identifies the application. This is the value that's sent as the `client_id` parameter on OAuth requests. Defaults to STS service(`sts.amazonaws.com`) if not values are provided."
  type        = set(string)
  default     = ["sts.amazonaws.com"]
  nullable    = false
}

variable "thumbprints" {
  description = "(Optional) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "auto_thumbprint_enabled" {
  description = "(Optional) Whether to automatically calculate thumbprint of the server certificate."
  type        = bool
  default     = true
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
