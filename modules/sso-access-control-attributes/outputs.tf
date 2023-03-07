output "instance_arn" {
  description = "The Amazon Resource Name (ARN) of the SSO Instance."
  value       = one(aws_ssoadmin_instance_access_control_attributes.this[*].instance_arn)
}

output "attributes" {
  description = "A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources."
  value = {
    for attr in try(one(aws_ssoadmin_instance_access_control_attributes.this[*]).attribute, []) :
    attr.key => tolist(tolist(attr.value)[0].source)[0]
  }
}

output "status" {
  description = "The status of ID of the Instance Access Control Attribute `instance_arn`."
  value       = one(aws_ssoadmin_instance_access_control_attributes.this[*].status)
}
