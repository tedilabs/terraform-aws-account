locals {
  # PRs to add more of these mappings are very welcome. For more information
  # on how to find the Service Code and Quota Code, see the README.md!
  quota_codes = {
    "vpc/rules-per-nacl"               = "L-2AEEBF1A"
    "vpc/security-groups-per-eni"      = "L-2AFB9258"
    "vpc/nat-gateways-per-az"          = "L-FE5A380F"
    "vpc/subnets-per-vpc"              = "L-407747CB"
    "vpc/internet-gateways-per-region" = "L-A4707A72"
    "vpc/vpcs-per-region"              = "L-F678F1CE"
    "ec2/eips-per-region"              = "L-0263D0A3"
  }
}
