locals {
  # PRs to add more of these mappings are very welcome. For more information
  # on how to find the Service Code and Quota Code, see the README.md!
  quota_codes = {
    # EC2
    "ec2/eips-per-region" = "L-0263D0A3"
    # FMS
    "fms/accounts-per-organization-filter"                         = "L-0C779DC8"
    "fms/applications-per-application-list"                        = "L-A423D1D9"
    "fms/rule-groups-per-dns-firewall-policy"                      = "L-5A240155"
    "fms/policies-per-region"                                      = "L-0B28E140"
    "fms/primary-security-groups-per-common-security-group-policy" = "L-2898441F"
    "fms/protocols-per-protocol-list"                              = "L-1513E67B"
    "fms/tags-per-resource-tags-filter"                            = "L-CDB85E02"
    "fms/rule-groups-per-waf-policy"                               = "L-F8EEB3E5"
    # IAM
    "iam/customer-managed-policies-per-account" = "L-E95E4862"
    "iam/instance-profiles-per-account"         = "L-6E65F664"
    "iam/managed-policies-per-role"             = "L-0DA4ABF3"
    "iam/managed-policies-per-user"             = "L-4019AD8B"
    "iam/roles-per-account"                     = "L-FE177D64"
    "iam/role-trust-policy-length"              = "L-C07B4B0D"
    # Resource Groups
    "resource-groups/resource-groups-per-account" = "L-2BAA18A0"
    # Route53
    "route53/health-checks-per-region"   = "L-ACB674F3"
    "route53/hosted-zones-per-region"    = "L-4EA4796A"
    "route53/delegation-sets-per-region" = "L-A72C7724"
    # Route53 Profiles
    "route53profiles/private-hosted-zone-associations-per-profile" = "L-BA3424AB"
    "route53profiles/profiles-per-region"                          = "L-D9B2356C"
    "route53profiles/vpc-associations-per-region"                  = "L-9BABD1D7"
    "route53profiles/vpc-endpoint-associations-per-profile"        = "L-0B404E57"
    # SES
    "ses/sending-emails-per-day"    = "L-804C8AE8"
    "ses/sending-emails-per-second" = "L-CDEF9B6B"
    # SSO
    "sso/permission-sets-total"              = "L-B44C7A29"
    "sso/permission-sets-per-aws-account"    = "L-89954265"
    "sso/aws-accounts-or-applications-total" = "L-0299121C"
    # VPC
    "vpc/rules-per-nacl"               = "L-2AEEBF1A"
    "vpc/rules-per-security-group"     = "L-0EA8095F"
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
  }
}

resource "aws_servicequotas_service_quota" "this" {
  for_each = {
    for code, quota in var.service_quotas.requests :
    code => {
      service_code = split("/", code)[0]
      quota_code   = split("/", code)[1]
      value        = quota
    }
  }

  region = var.region

  service_code = each.value.service_code
  quota_code = (
    var.service_quotas.code_translation_enabled
    ? local.quota_codes[each.key]
    : each.value.quota_code
  )
  value = each.value.value
}
