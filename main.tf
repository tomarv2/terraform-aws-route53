terraform {
  required_version            = ">= 0.14"
  required_providers {
    aws = {
      version                     = "~> 2.61"
    }
  }
}

module "global" {
    source                    = "git::git@github.com:tomarv2/terraform-global.git?ref=0.0.1//aws"
}

locals {
  shared_tags  = map(
      "Name", "${var.teamid}-${var.prjid}",
      "Owner", var.email,
      "Team", var.teamid,
      "Project", var.prjid
  )
}
