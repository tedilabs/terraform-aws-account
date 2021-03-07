locals {
  # PRs to add more of these mappings are very welcome. For more information
  # on how to find the Service Code and Quota Code, see the README.md!
  quota_codes = {
    "vpc/rules-per-nacl"          = "L-2AEEBF1A"
    "vpc/security-groups-per-eni" = "L-2AFB9258"
    "vpc/nat-gateways-per-az"     = "L-FE5A380F"
  }
}
