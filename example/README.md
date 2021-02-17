# AWS Route53

Terraform to create Route53 on AWS.

This module focuses on [Route53](https://aws.amazon.com/route53/)

**NOTE:** In most cases creating resources is heavily opinionated and or context-bound. 

## Terraform versions

Terraform 0.12 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| alb\_zoneid | n/a | `any` | n/a | yes |
| aws\_region | n/a | `any` | n/a | yes |
| dns\_name | n/a | `any` | n/a | yes |
| email | Team email, not individual email | `any` | n/a | yes |
| evaluate\_target\_health | n/a | `bool` | `true` | no |
| prjid | Name of the project/stack.  EG: mystack | `any` | n/a | yes |
| teamid | Name of the team or group e.g. devops, dataengineering. Should not be changed after running 'tf apply'. | `any` | n/a | yes |
| type\_of\_record | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| route53\_zoneid | fqdn |
