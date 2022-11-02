terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 4.35"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "route53" {
  source = "../../"

  config = {
    delme = {
      type        = "A"
      zone_id     = "Z1234567890I"
      ttl         = "3600"
      records     = ["10.0.0.27"]
      domain_name = "deleme.com"
      alias_config = {
        name                   = "sdfs"
        zone_id                = "Z1234567890I"
        evaluate_target_health = "false"
      }
      zone_config = {
        name              = "test"
        comment           = "test1"
        force_destroy     = false
        delegation_set_id = "dfgd"
        vpc = {
          "demo" = {
            region = "us-west-2"
          }
        }
        vpc = {
          vpc_id = "vpc12345"
          region = "us-west-2"
        }
      }
    }
  }
}
