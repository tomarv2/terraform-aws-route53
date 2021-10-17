provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

module "route53" {
  source = "../../"

  account_id     = "<account_id>"
  public_enabled = true
  domain_name    = "demo.rumse.com"
  names = [
    "delme-test"
  ]
  types_of_records = [
    "CNAME"
  ]
  alias = {
    names = [
      "1234567890.execute-api.us-west-2.amazonaws.com"
    ]
    zone_ids = [
      "Z1234567890I" # Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone.
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
