module "route53" {
  source = "../"

  deploy_route53 = false
  email          = "demo@demo.com"
  lb_zoneid      = "ABC123"
  account_id     = "123456789012"
  dns_name       = "demo.demo.com"
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}


