// 2022-11-24
moved {
  from = aws_resourcegroups_group.this[0]
  to   = module.resource_group[0].aws_resourcegroups_group.this
}
