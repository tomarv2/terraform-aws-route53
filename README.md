# terraform-aws-route53
Terraform module for route53

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 2.61 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.61 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| alb\_zoneid | n/a | `any` | n/a | yes |
| aws\_region | n/a | `any` | n/a | yes |
| deploy\_route53 | n/a | `bool` | `false` | no |
| dns\_name | n/a | `any` | n/a | yes |
| email | Team email, not individual email | `any` | n/a | yes |
| evaluate\_target\_health | n/a | `any` | n/a | yes |
| prjid | Name of the project/stack.  EG: mystack | `any` | n/a | yes |
| teamid | Name of the team or group e.g. devops, dataengineering. Should not be changed after running 'tf apply'. | `any` | n/a | yes |
| ttl | n/a | `string` | `"300"` | no |
| type\_of\_record | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| route53\_fdqn | fqdn |
