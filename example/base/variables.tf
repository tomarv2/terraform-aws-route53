variable "email" {
  description = "email address to be used for tagging (suggestion: use group email address)"
}

variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default = "default"
}

variable "dns_name" {}

variable "type_of_record" {}

variable "lb_zoneid" {}

variable "evaluate_target_health" {
  default = true
}

variable "account_id" {}

variable "aws_region" {
  default = "us-west-2"
}
