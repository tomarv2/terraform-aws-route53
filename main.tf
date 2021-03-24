module "global" {
  source = "git::git@github.com:tomarv2/terraform-global.git//aws"
}

locals {
  shared_tags = map(
    "name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )
}
