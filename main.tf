module "acm_certificate" {
  providers = {
    aws = aws.global
  }

  source  = "operatehappy/acm-certificate/aws"
  version = "1.0.0"

  domain_name            = var.domain_name
  alternate_domain_names = var.alternate_domain_names

  use_default_tags                    = true
  tags                                = var.acm_tags
  enable_certificate_transparency_log = var.acm_enable_certificate_transparency_log
  route53_zone_id                     = var.route53_zone_id
}

module "s3_bucket" {
  providers = {
    aws = aws.distribution
  }

  source  = "operatehappy/s3-bucket/aws"
  version = "1.1.4"

  name             = var.s3_bucket_name
  use_prefix       = var.s3_use_prefix
  policy           = var.s3_policy
  acl              = "private"
  use_default_tags = var.s3_use_default_tags
  tags             = local.s3_merged_tags
  force_destroy    = var.s3_force_destroy
  create_readme    = var.s3_create_readme
}

resource "aws_cloudfront_origin_access_identity" "this" {
  provider = aws.distribution

  comment = local.cloudfront_origin_access_identity_comment
}

data "aws_iam_policy_document" "this" {
  provider = aws.distribution

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

// NOTE: Bucket Policies could also be set by passing the `policy` attribute to the `s3_bucket` Module.
// NOTE: This might result in a race-condition as the Distribution is dependent on output from `s3_bucket`.
resource "aws_s3_bucket_policy" "this" {
  provider = aws.distribution

  bucket = module.s3_bucket.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_cloudfront_distribution" "this" {
  provider = aws.global

  aliases = length(local.concatenated_records) > 0 ? local.concatenated_records : [var.domain_name]
  comment = var.cloudfront_comment

  // TODO: multiples allowed
  //  custom_error_response {
  //    error_code = 0
  //  }

  // TODO: turn into variable
  //  dynamic "default_cache_behavior" {
  //    for_each = var.default_cache_behavior
  //
  //    content {
  //      allowed_methods = lookup(default_cache_behavior.value, "allowed_methods", null)
  //      cached_methods = lookup(default_cache_behavior.value, "cached_methods", null)
  //      target_origin_id = lookup(default_cache_behavior.value, "target_origin_id", null)
  //      expose_headers  = lookup(default_cache_behavior.value, "expose_headers", null)
  //      max_age_seconds = lookup(default_cache_behavior.value, "max_age_seconds", null)
  //    }
  //  }

  default_cache_behavior {
    target_origin_id = local.s3_origin_id
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 3600
  }

  default_root_object = var.cloudfront_default_root_object

  enabled         = var.cloudfront_enabled
  is_ipv6_enabled = var.cloudfront_is_ipv6_enabled
  http_version    = var.cloudfront_http_version

  //  logging_config {
  //    include_cookies = false
  //    bucket          = "mylogs.s3.amazonaws.com"
  //    prefix          = "myprefix"
  //  }

  origin {
    domain_name = module.s3_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  // TODO: multiples allowed
  //  origin_group {
  //    origin_id = ""
  //    failover_criteria {
  //      status_codes = []
  //    }
  //    member {
  //      origin_id = ""
  //    }
  //  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = local.cloudfront_merged_tags

  viewer_certificate {
    acm_certificate_arn      = module.acm_certificate.arn
    minimum_protocol_version = var.cloudfront_minimum_protocol_version
    ssl_support_method       = var.cloudfront_ssl_support_method
  }
}

resource "aws_route53_record" "this" {
  provider = aws.global

  count = length(local.concatenated_records)

  zone_id = var.route53_zone_id
  name    = local.concatenated_records[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}
