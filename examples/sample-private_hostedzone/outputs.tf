output "route53_fdqn" {
  description = "Route53 FQDN"
  value       = module.route53.route53_fdqn
}

output "zone_id" {
  description = "Public zone id"
  value       = module.route53.zone_id
}
