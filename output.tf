output "route53_fdqn" {
  description = "fqdn"
  value       = join("", aws_route53_record.www.*.fqdn)
}
