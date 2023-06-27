output "policies" {
  description = "A list of policies which are managed by this module."
  value = {
    for name, policy in aws_iam_policy.this :
    name => {
      id          = policy.id
      arn         = policy.arn
      name        = policy.name
      path        = policy.path
      description = policy.description
    }
  }
}
