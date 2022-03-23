<p align="center">
    <a href="https://github.com/tomarv2/terraform-aws-route53/actions/workflows/pre-commit.yml" alt="Pre commit">
        <img src="https://github.com/tomarv2/terraform-aws-route53/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-aws-route53" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-route53/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-route53" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-route53/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-aws-route53" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [AWS Route53](https://aws.amazon.com/route53/)

> :arrow_right:  Terraform module for [Google Cloud DNS](https://registry.terraform.io/modules/tomarv2/cloud-dns/google/latest)


### Versions

- Module tested for Terraform 1.0.1.
- AWS provider version [3.74](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-route53/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-route53" /></a> ).

### Usage

#### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

#### Option 2:

##### Recommended method (stores remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export TF_AWS_PROFILE=<profile from ~/.ws/credentials>
```

or

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export AWS_ACCESS_KEY_ID=<aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<aws_secret_access_key>
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -c=aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=aws destroy -var='teamid=foo' -var='prjid=bar'
```

**Note:** Read more on [tfremote](https://github.com/tomarv2/tfremote)
##### Route53 with Private Hostedzone

```
module "route53" {
  source = "../../"

  private_enabled = true
  account_id      = "123456789012"
  aws_region      = "us-east-2"
  domain_name     = "deleme.com"
  names = [
    "delme-vt.",
    "delme-vt1."
  ]
  types = [
    "A",
    "CNAME"
  ]
  ttls = [
    "3600",
    "3600",
  ]
  values = [
    "10.0.0.27",
    "google.com",
  ]
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

##### Route53 with Public Hosted zone
```
module "route53" {
  source = "../../"

  account_id     = "123456789012"
  public_enabled = true
  domain_name    = "deleme-public.com"
  names = [
    "delme-test"
  ]
  types = [
    "A"
  ]
  alias = {
    names = [
      "dualstack.delme.us-west-2.elb.amazonaws.com"
    ]
    zone_ids = [
      "Z1234567890125" # Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone.
    ]
    evaluate_target_healths = [
      false
    ]
  }
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_global"></a> [global](#module\_global) | git::git@github.com:tomarv2/terraform-global.git//aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | aws account id to deploy resources | `string` | n/a | yes |
| <a name="input_alias"></a> [alias](#input\_alias) | An alias block. Conflicts with ttl & records. Alias record documented below. | `map(any)` | <pre>{<br>  "evaluate_target_healths": [],<br>  "names": [],<br>  "zone_ids": []<br>}</pre> | no |
| <a name="input_allow_overwrites"></a> [allow\_overwrites](#input\_allow\_overwrites) | Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. | `list(any)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | aws region to deploy resources | `string` | n/a | yes |
| <a name="input_comment"></a> [comment](#input\_comment) | A comment for the hosted zone. Defaults to 'Managed by Terraform'. | `string` | `null` | no |
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones. | `string` | `""` | no |
| <a name="input_deploy_route53"></a> [deploy\_route53](#input\_deploy\_route53) | Feature flag, true or false | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `true` | no |
| <a name="input_health_check_ids"></a> [health\_check\_ids](#input\_health\_check\_ids) | The health check the record should be associated with. | `list(any)` | `[]` | no |
| <a name="input_multivalue_answer_routing_policies"></a> [multivalue\_answer\_routing\_policies](#input\_multivalue\_answer\_routing\_policies) | Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy. | `list(any)` | `[]` | no |
| <a name="input_names"></a> [names](#input\_names) | The name of the record. | `list(any)` | `[]` | no |
| <a name="input_private_enabled"></a> [private\_enabled](#input\_private\_enabled) | Whether to create private Route53 zone. | `bool` | `false` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_public_enabled"></a> [public\_enabled](#input\_public\_enabled) | Whether to create public Route53 zone. | `bool` | `false` | no |
| <a name="input_set_identifiers"></a> [set\_identifiers](#input\_set\_identifiers) | Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below. | `list(any)` | `[]` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_ttls"></a> [ttls](#input\_ttls) | (Required for non-alias records) The TTL of the record. | `list(any)` | `[]` | no |
| <a name="input_types_of_records"></a> [types\_of\_records](#input\_types\_of\_records) | The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. | `list(any)` | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add "" inside the Terraform configuration string (e.g. "first255characters""morecharacters"). | `list(any)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC to associate with the private hosted zone. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_zone_id"></a> [private\_zone\_id](#output\_private\_zone\_id) | Private zone id |
| <a name="output_public_zone_id"></a> [public\_zone\_id](#output\_public\_zone\_id) | Public zone id |
| <a name="output_route53_fdqn"></a> [route53\_fdqn](#output\_route53\_fdqn) | Route53 FQDN |
