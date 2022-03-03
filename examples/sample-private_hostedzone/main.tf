terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}


provider "aws" {
  region = var.region
}

module "route53" {
  source = "../../"

  private_enabled = true

  domain_name = "deleme.com"
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
