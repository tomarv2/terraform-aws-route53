locals {
  alias_settings = try(flatten([
    for alias, config in var.config : {
      name                   = config.alias_config.name
      zone_id                = config.alias_config.zone_id
      evaluate_target_health = try(config.alias_config.evaluate_target_health, false)
  }]), {})

  zone_settings = try(flatten([
    for zone, config in var.config : {
      name              = config.zone_config.name
      comment           = config.zone_config.comment
      force_destroy     = config.zone_config.force_destroy
      delegation_set_id = try(config.zone_config.delegation_set_id, null)
      vpc               = try(config.zone_config.vpc, null) == null ? try(config.zone_config.vpc, {}) : {}
    }
  ]), {})
}

resource "aws_route53_record" "this" {
  for_each = var.config

  name                             = each.key
  zone_id                          = local.zone_settings != {} ? join("", [for this in aws_route53_zone.this : this.zone_id]) : each.value.zone_id
  type                             = try(each.value.type, "CNAME")
  ttl                              = try(each.value.alias_config, null) == null ? try(each.value.ttl, "3600") : null
  records                          = try(each.value.alias_config, null) == null ? try(each.value.records, []) : null
  set_identifier                   = try(each.value.set_identifier, "")
  health_check_id                  = try(each.value.health_check_id, "")
  multivalue_answer_routing_policy = try(each.value.multivalue_answer_routing_policy, false)
  allow_overwrite                  = try(each.value.allow_overwrites, false)

  dynamic "alias" {
    for_each = { for i in local.alias_settings : "${i.name}" => i }

    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }
}

resource "aws_route53_zone" "this" {
  for_each = { for i in local.zone_settings : "${i.name}" => i }

  name              = each.value.name
  comment           = each.value.comment
  force_destroy     = each.value.force_destroy
  delegation_set_id = each.value.delegation_set_id

  dynamic "vpc" {
    for_each = each.value.vpc
    content {
      vpc_id     = vpc.key
      vpc_region = vpc.value.region
    }
  }

  tags = merge(local.shared_tags, var.extra_tags)
}

