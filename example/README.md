
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| aws\_region | n/a | `string` | `"us-west-2"` | no |
| dns\_name | n/a | `any` | n/a | yes |
| email | email address to be used for tagging (suggestion: use group email address) | `any` | n/a | yes |
| evaluate\_target\_health | n/a | `bool` | `true` | no |
| lb\_zoneid | n/a | `any` | n/a | yes |
| prjid | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `string` | `"default"` | no |
| teamid | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| type\_of\_record | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| route53\_zoneid | fqdn |
