output "route53_fdqn" {
  description = "Route53 FQDN"
  value       = module.route53.route53_fdqn
}

output "public_zone_id" {
  description = "Public zone id"
  value       = module.route53.public_zone_id
}

output "private_zone_id" {
  description = "Private zone id"
  value       = module.route53.private_zone_id
}
