locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  zone_id = var.private_enabled != true ? module.global.route53_zoneid[local.account_id] : aws_route53_zone.private.*.zone_id[0]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
