locals {
  # PRs to add more of these mappings are very welcome. For more information
  # on how to find the Service Code and Quota Code, see the README.md!
  quota_codes = {
    # VPC
    "vpc/rules-per-nacl"               = "L-2AEEBF1A"
    "vpc/security-groups-per-eni"      = "L-2AFB9258"
    "vpc/nat-gateways-per-az"          = "L-FE5A380F"
    "vpc/subnets-per-vpc"              = "L-407747CB"
    "vpc/internet-gateways-per-region" = "L-A4707A72"
    "vpc/vpcs-per-region"              = "L-F678F1CE"
    # VPC IPAM (IP Address Manager)
    "vpc-ipam/ipams-per-region" = "L-F8B4A9E6"
    "vpc-ipam/scopes-per-ipam"  = "L-F493CFD2"
    "vpc-ipam/pools-per-scope"  = "L-7319AFC3"
    "vpc-ipam/cidrs-per-pool"   = "L-0BC051D6"
    "vpc-ipam/pool-depth"       = "L-047C0565"
    # EC2
    "ec2/eips-per-region" = "L-0263D0A3"
    # Route53
    "route53/health-checks-per-region"   = "L-ACB674F3"
    "route53/hosted-zones-per-region"    = "L-4EA4796A"
    "route53/delegation-sets-per-region" = "L-A72C7724"
    # SES
    "ses/sending-emails-per-day" = "L-804C8AE8"
    # SSO
    "sso/permission-sets-total"              = "L-B44C7A29"
    "sso/permission-sets-per-aws-account"    = "L-89954265"
    "sso/aws-accounts-or-applications-total" = "L-0299121C"
    # Resource Groups
    "resource-groups/resource-groups-per-account" = "L-2BAA18A0"
  }
}
