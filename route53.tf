# NOTE: will not deploy route53 as value is set to false in variables
# to deploy route 53, change value of  deploy_route53 to `true` and provide required variables

resource "aws_route53_record" "www" {
  count   = var.deploy_route53 ? 1 : 0

  zone_id                           = module.global.route53_zoneid[var.account_id][var.aws_region]
  name                              = var.dns_name
  type                              = var.type_of_record

  alias {
    name                            = "${var.teamid}-${var.prjid}"
    zone_id                         = var.lb_zoneid
    evaluate_target_health          = var.evaluate_target_health
  }

}
