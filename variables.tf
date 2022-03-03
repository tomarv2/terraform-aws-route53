variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "private_enabled" {
  type        = bool
  default     = false
  description = "Whether to create private Route53 zone."
}

variable "deploy_route53" {
  type        = bool
  default     = true
  description = "feature flag, true or false"
}

variable "public_enabled" {
  type        = bool
  default     = false
  description = "Whether to create public Route53 zone."
}

variable "comment" {
  type        = string
  default     = null
  description = "A comment for the hosted zone. Defaults to 'Managed by Terraform'."
}

variable "force_destroy" {
  type        = bool
  default     = true
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
}

variable "delegation_set_id" {
  type        = string
  default     = ""
  description = "The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones."
}

variable "types_of_records" {
  type        = list(any)
  default     = []
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. "
}

variable "ttls" {
  type        = list(any)
  default     = []
  description = "(Required for non-alias records) The TTL of the record."
}

variable "names" {
  type        = list(any)
  default     = []
  description = "The name of the record."
}

variable "values" {
  type        = list(any)
  default     = []
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g. \"first255characters\"\"morecharacters\")."
}

variable "set_identifiers" {
  type        = list(any)
  default     = []
  description = "Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below."
}

variable "health_check_ids" {
  type        = list(any)
  default     = []
  description = "The health check the record should be associated with."
}

variable "alias" {
  type        = map(any)
  default     = { "names" = [], "zone_ids" = [], "evaluate_target_healths" = [] }
  description = "An alias block. Conflicts with ttl & records. Alias record documented below."
}

variable "multivalue_answer_routing_policies" {
  type        = list(any)
  default     = []
  description = "Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy."
}

variable "allow_overwrites" {
  type        = list(any)
  default     = []
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
}

variable "account_id" {
  description = "aws account id to deploy resources"
  type        = string
}

variable "aws_region" {
  description = "aws region to deploy resources"
  type        = string
}

variable "domain_name" {
  description = "The domain name"
  default     = null
  type        = string
}

variable "vpc_id" {
  default     = null
  description = "The VPC to associate with the private hosted zone."
  type        = string
}
