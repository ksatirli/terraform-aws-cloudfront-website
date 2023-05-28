# see https://registry.terraform.io/modules/ksatirli/acm-certificate/aws/2.2.0
module "acm_certificate" {
  source  = "ksatirli/acm-certificate/aws"
  version = "2.2.0"

  # see https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations
  providers = {
    # NOTE: ACM Certificates for usage with CloudFront need to be created in the `us-east-1` region, see https://amzn.to/2TW2J16
    aws.certificate = aws.certificate
  }

  domain_name            = local.primary_record
  alternate_domain_names = var.alternate_subdomain_names
  route53_zone_id        = data.aws_route53_zone.main.id
  tags                   = var.tags
}
