resource "aws_route53_zone" "private" {
  count = var.private_enabled ? 1 : 0

  name          = var.domain_name
  comment       = var.comment == null ? "Terraform managed: ${var.teamid}-${var.prjid}" : var.comment
  force_destroy = var.force_destroy
  tags          = merge(local.shared_tags)
  vpc {
    vpc_id = var.vpc_id != null ? var.vpc_id : module.global.vpc[local.account_id][local.region]
  }
}

resource "aws_route53_zone" "public" {
  count = var.public_enabled ? 1 : 0

  name              = var.domain_name
  delegation_set_id = var.delegation_set_id
  comment           = var.comment == null ? "Terraform managed: ${var.teamid}-${var.prjid}" : var.comment
  force_destroy     = var.force_destroy
  tags              = merge(local.shared_tags)
}
