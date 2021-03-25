<p align="center">
    <a href="https://github.com/tomarv2/terraform-aws-route53/actions/workflows/security_scans.yml" alt="Security Scans">
        <img src="https://github.com/tomarv2/terraform-aws-route53/actions/workflows/security_scans.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-aws-route53" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-route53/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-route53" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-route53/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-aws-route53" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

# Terraform module for [AWS Route53](https://aws.amazon.com/route53/)

> :arrow_right:  Terraform module for [Google Cloud DNS](https://registry.terraform.io/modules/tomarv2/cloud-dns/google/latest)


## Versions

- Module tested for Terraform 0.14.
- AWS provider version [3.29.0](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-route53/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-route53" /></a> in your releases)

**NOTE:** 

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

## Usage 

Recommended method:

- Create python 3.6+ virtual environment 
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_PROFILE=default
export TF_AWS_BUCKET_REGION=us-west-2
```  

- Updated `examples` directory with required values. 

- Run and verify the output before deploying:
```
tf -cloud aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -cloud aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -cloud aws destroy -var='teamid=foo' -var='prjid=bar'
```

> ❗️ **Important** - Two variables are required for using `tf` package:
>
> - teamid
> - prjid
>
> These variables are required to set backend path in the remote storage.
> Variables can be defined using:
>
> - As `inline variables` e.g.: `-var='teamid=demo-team' -var='prjid=demo-project'`
> - Inside `.tfvars` file e.g.: `-var-file=<tfvars file location> `
>
> For more information refer to [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html)

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

##### Route53 with Public Hostedzone
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
| terraform | >= 0.14 |
| aws | ~> 3.29 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.29 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| alias | An alias block. Conflicts with ttl & records. Alias record documented below. | `map(any)` | <pre>{<br>  "evaluate_target_healths": [],<br>  "names": [],<br>  "zone_ids": []<br>}</pre> | no |
| allow\_overwrites | Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. | `list(any)` | `[]` | no |
| application | Application (e.g. `cd` or `clouddrove`). | `string` | `""` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| aws\_region | n/a | `string` | `"us-west-2"` | no |
| comment | A comment for the hosted zone. Defaults to 'Managed by Terraform'. | `string` | `null` | no |
| delegation\_set\_id | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones. | `string` | `""` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| deploy\_route53 | Whether to create Route53 record set. | `bool` | `true` | no |
| domain\_name | The domain name | `any` | `null` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| failover\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| failover\_routing\_policies | A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| force\_destroy | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `true` | no |
| geolocation\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| geolocation\_routing\_policies | A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| health\_check\_ids | The health check the record should be associated with. | `list(any)` | `[]` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| latency\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| latency\_routing\_policies | A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| multivalue\_answer\_routing\_policies | Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy. | `list(any)` | `[]` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| names | The name of the record. | `list(any)` | `[]` | no |
| private\_enabled | Whether to create private Route53 zone. | `bool` | `false` | no |
| prjid | (Required) name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `string` | `"default"` | no |
| public\_enabled | Whether to create public Route53 zone. | `bool` | `false` | no |
| record\_set\_enabled | Whether to create seperate Route53 record set. | `bool` | `false` | no |
| secondary\_vpc\_id | The VPC to associate with the private hosted zone. | `string` | `""` | no |
| secondary\_vpc\_region | The VPC's region. Defaults to the region of the AWS provider. | `string` | `""` | no |
| set\_identifiers | Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below. | `list(any)` | `[]` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| teamid | (Required) name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| ttls | (Required for non-alias records) The TTL of the record. | `list(any)` | `[]` | no |
| types | The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. | `list(any)` | `[]` | no |
| values | (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add "" inside the Terraform configuration string (e.g. "first255characters""morecharacters"). | `list(any)` | `[]` | no |
| vpc\_id | VPC ID. | `string` | `""` | no |
| weighted\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| weighted\_routing\_policies | A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_zone\_id | n/a |
| public\_zone\_id | n/a |
| route53\_fdqn | Route53 FQDN |
