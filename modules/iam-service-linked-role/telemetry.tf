variable "telemetry" {
  description = <<EOF
  (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.
    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.
    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.
    (Optional) `capture_network` - Whether to capture network information. Default is `true`.
    (Optional) `capture_git` - Whether to capture git information. Default is `true`.
    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.
    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.
    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.
    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.
    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.
    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`.
  EOF
  type = object({
    enabled = optional(bool, true)

    capture_machine        = optional(bool, true)
    capture_network        = optional(bool, true)
    capture_git            = optional(bool, true)
    capture_github         = optional(bool, true)
    capture_github_actions = optional(bool, true)
    capture_hcp_terraform  = optional(bool, true)
    capture_terraform      = optional(bool, true)
    capture_toolchain      = optional(bool, true)

    pseudonymization_enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

check "telemetry" {
  assert {
    # A null connection disables the call. Wrapping the call in a conditional
    # expression would not, because Terraform evaluates both of its results.
    condition = provider::telemetry::capture_posthog(
      var.telemetry.enabled ? {
        host          = "https://us.i.posthog.com"
        project_token = "phc_xwn7HLdbaLxDAq7gbiKTbbJt5oMtXHkRRmaN8aeWeUnk"
      } : null,
      {
        machine        = var.telemetry.capture_machine
        network        = var.telemetry.capture_network
        git            = var.telemetry.capture_git
        github         = var.telemetry.capture_github
        github_actions = var.telemetry.capture_github_actions
        hcp_terraform  = var.telemetry.capture_hcp_terraform
        terraform      = var.telemetry.capture_terraform
        toolchain      = var.telemetry.capture_toolchain

        cache_enabled         = true
        deduplication_enabled = true
        deduplication_keys    = ["terraform.module.package", "terraform.module.version", "terraform.module.name"]

        pseudonymization = {
          enabled = var.telemetry.pseudonymization_enabled
        }
        identity_keys = [
          "git.remote",
        ]
      },
      {
        terraform = {
          module = {
            package   = local.metadata.package
            version   = local.metadata.version
            name      = local.metadata.module
            full-name = "${local.metadata.package}/${local.metadata.module}"
          }
        }
      }
    )

    error_message = "Telemetry invocation failed."
  }
}
