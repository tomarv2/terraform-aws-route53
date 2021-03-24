variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to create resources"
  default     = "us-west-2"
}

variable "dns_name" {
  description = "DNS name"
  default     = ""
}

variable "type_of_record" {
  description = "type of DNS record"
  default     = "A"
}

variable "ttl" {
  description = "DNS timeout"
  default     = "300"
}

variable "deploy_route53" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "lb_zoneid" {}

variable "evaluate_target_health" {
  description = "evaluate route53 health"
  default     = true
  type        = bool
}

variable "account_id" {
  description = "(Required) AWS account id (used to pull values from shared base module like vpc info, subnet ids)"
}
