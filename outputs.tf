output "route53_fdqn" {
  description = "Route53 FQDN"
  value       = join("", aws_route53_record.default.*.fqdn)
}

output "public_zone_id" {
  description = "Public zone id"
  value       = join("", aws_route53_zone.public.*.zone_id)
}

output "private_zone_id" {
  description = "Private zone id"
  value       = join("", aws_route53_zone.public.*.zone_id)
}
