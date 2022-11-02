output "route53_fdqn" {
  description = "Route53 FQDN"
  value       = [for entry in aws_route53_record.this : entry.arn]
}

output "zone_id" {
  description = "Route53 zone id"
  value       = [for entry in aws_route53_zone.this : this.zone_id]
}
