variable "telemetry" {
  description = <<EOF
  (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. The data collected is anonymous and does not contain any sensitive information. The default configuration enables telemetry collection for machine, network, git, github, github actions, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.
    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.
    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.
    (Optional) `capture_network` - Whether to capture network information. Default is `true`.
    (Optional) `capture_git` - Whether to capture git information. Default is `true`.
    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.
    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.
    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.
    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.
  EOF
  type = object({
    enabled = optional(bool, true)

    capture_machine        = optional(bool, true)
    capture_network        = optional(bool, true)
    capture_git            = optional(bool, true)
    capture_github         = optional(bool, true)
    capture_github_actions = optional(bool, true)
    capture_terraform      = optional(bool, true)
    capture_toolchain      = optional(bool, true)
  })
  default  = {}
  nullable = false
}

check "telemetry" {
  assert {
    condition = var.telemetry.enabled ? provider::telemetry::capture_posthog(
      {
        host          = "https://us.i.posthog.com"
        project_token = "phc_xwn7HLdbaLxDAq7gbiKTbbJt5oMtXHkRRmaN8aeWeUnk"
      },
      {
        machine        = var.telemetry.capture_machine
        network        = var.telemetry.capture_network
        git            = var.telemetry.capture_git
        github         = var.telemetry.capture_github
        github_actions = var.telemetry.capture_github_actions
        terraform      = var.telemetry.capture_terraform
        toolchain      = var.telemetry.capture_toolchain

        cache_enabled         = true
        deduplication_enabled = true
        deduplication_keys    = ["terraform.module.package", "terraform.module.version", "terraform.module.name"]
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
    ) : true

    error_message = "Telemetry invocation failed."
  }
}
