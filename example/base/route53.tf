module "route53" {
  source = "../.."

  email                                 = var.email
  teamid                                = var.teamid
  prjid                                 = var.prjid
  lb_zoneid                             = var.lb_zoneid
  evaluate_target_health                = var.evaluate_target_health
  account_id                            = var.account_id
  dns_name                              =  var.dns_name
  type_of_record                        = var.type_of_record
}

