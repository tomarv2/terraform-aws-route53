output "route53_fdqn" {
  description = "fqdn"
  value       = aws_route53_record.www.*.fqdn
}
