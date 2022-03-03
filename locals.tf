locals {
  shared_tags = tomap(
    {
      "Name"    = "${var.teamid}-${var.prjid}",
      "team"    = var.teamid,
      "project" = var.prjid
    }
  )

  account_id = data.aws_caller_identity.current.account_id

  zone_id = var.private_enabled != true ? module.global.route53_zoneid[local.account_id] : aws_route53_zone.private.*.zone_id[0]
}

data "aws_caller_identity" "current" {}
