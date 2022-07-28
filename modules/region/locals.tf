data "aws_region" "this" {}

locals {
  region_codes = {
    "us-east-1"      = "use1"
    "us-east-2"      = "use2"
    "us-west-1"      = "usw1"
    "us-west-2"      = "usw2"
    "af-south-1"     = "afs1"
    "ap-east-1"      = "ape1"
    "ap-northeast-1" = "apne1"
    "ap-northeast-2" = "apne2"
    "ap-northeast-3" = "apne3"
    "ap-southeast-1" = "apse1"
    "ap-southeast-2" = "apse2"
    "ap-southeast-3" = "apse3"
    "ap-south-1"     = "aps1"
    "ca-central-1"   = "cac1"
    "eu-central-1"   = "euc1"
    "eu-west-1"      = "euw1"
    "eu-west-2"      = "euw2"
    "eu-west-3"      = "euw3"
    "eu-north-1"     = "eun1"
    "eu-south-1"     = "eus1"
    "me-south-1"     = "mes1"
    "sa-east-1"      = "sae1"
    "cn-north-1"     = "cn1"
    "us-gov-west-1"  = "usgw1"
    "us-gov-east-1"  = "usge1"
  }

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
