# The Route53 Zone Data Source is solely used to retrieve a Route53 Zone ID.
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
data "aws_route53_zone" "domain" {
  name = var.route53_zone_name

  # Additional settings may be set here to make the filtering
  # consider only private zones, VPCs, and matching tags.
}

# The Random Provider is solely used to create a random suffix for the S3 Bucket resource.
# see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_suffix" {
  length  = 4
  lower   = true
  special = false
  upper   = false
}

module "website" {
  source = "../.."

  # see https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations
  providers = {
    # NOTE: ACM Certificates for usage with CloudFront must be created in the `us-east-1` region, see https://amzn.to/2TW2J16
    aws.certificate = aws.certificate
  }

  s3_bucket_name = "module-test-${random_string.bucket_suffix.id}"
  domain_name    = data.aws_route53_zone.domain.name
  subdomain_name = "www"
}
