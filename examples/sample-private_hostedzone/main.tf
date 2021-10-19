provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

module "route53" {
  source = "../../"

  private_enabled = true
  account_id      = "<account_id>>"
  aws_region      = "us-east-2"
  domain_name     = "deleme.com"
  names = [
    "delme-vt.",
    "delme-vt1."
  ]
  types_of_records = [
    "A",
    "CNAME"
  ]
  ttls = [
    "3600",
    "3600",
  ]
  values = [
    "10.0.0.27",
    "google.com",
  ]
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
