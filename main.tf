# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "main" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
data "aws_route53_zone" "main" {
  name = var.domain_name
}

# see https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html#managed-cache-policies-list
# and https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy
data "aws_cloudfront_cache_policy" "main" {
  name = var.cloudfront_cache_policy
}

# see https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html
# and https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_origin_request_policy
data "aws_cloudfront_origin_request_policy" "main" {
  name = var.cloudfront_origin_request_policy
}

# see https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-response-headers-policies.html
# and https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_response_headers_policy
data "aws_cloudfront_response_headers_policy" "main" {
  name = var.cloudfront_response_headers_policy
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control
resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "S3-${aws_s3_bucket.main.id}"
  description                       = "Terraform-managed Origin Access Control for ${data.aws_route53_zone.main.name}."
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

locals {
  # create list of subdomain name and alternate domain names
  aliases      = length(var.alternate_subdomain_names) > 0 ? concat(var.alternate_subdomain_names, [ local.primary_record ]) : [ local.primary_record]
  s3_origin_id = "S3-${aws_s3_bucket.main.id}"
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
resource "aws_cloudfront_distribution" "main" {
  aliases = local.aliases
  comment = "Terraform-managed CloudFront Distribution for ${local.primary_record}.${var.domain_name}."

  # see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#default-cache-behavior-arguments
  default_cache_behavior {
    target_origin_id = local.s3_origin_id

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    cache_policy_id            = data.aws_cloudfront_cache_policy.main.id
    compress                   = true
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.main.id
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.main.id
    viewer_protocol_policy     = "redirect-to-https"
  }

  default_root_object = var.cloudfront_default_root_object
  enabled             = var.cloudfront_enabled
  is_ipv6_enabled     = var.cloudfront_is_ipv6_enabled
  http_version        = var.cloudfront_http_version

  origin {
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
    origin_id                = local.s3_origin_id
  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = var.cloudfront_retain_on_delete
  tags             = var.tags

  viewer_certificate {
    acm_certificate_arn      = module.acm_certificate.aws_acm_certificate_validation.certificate_arn
    minimum_protocol_version = var.cloudfront_minimum_protocol_version
    ssl_support_method       = var.cloudfront_ssl_support_method
  }
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "main" {
  statement {
    sid = aws_s3_bucket.main.id

    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    principals {
      type = "Service"

      identifiers = [
        "cloudfront.amazonaws.com"
      ]
    }

    resources = [
      "${aws_s3_bucket.main.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.main.arn
      ]
    }
  }
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.main.json
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(local.aliases)

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
