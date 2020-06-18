variable "region" {
  type        = string
  description = "Region of S3 Bucket"
  default     = null
}

variable "domain_name" {
  type        = string
  description = "Domain name of website"
}

variable "alternate_domain_names" {
  type        = list(string)
  description = "Alternate Domain Names of Website"
  default     = []
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of S3 Bucket"
}

variable "s3_use_prefix" {
  type        = bool
  description = "Toggle to use randomly-generated Prefix for Bucket Name"
  default     = false
}

variable "s3_policy" {
  type        = string
  description = "Policy (JSON) Document of S3 Bucket"
  default     = null
}

variable "s3_use_default_tags" {
  type        = bool
  description = "Toggle to enable creation of default tags for S3 Bucket, containing Terraform Workspace identifier"
  default     = true
}

variable "s3_tags" {
  type        = map(string)
  description = "Mapping of Tags of S3 Bucket"
  default     = {}
}

variable "s3_force_destroy" {
  type        = bool
  description = "Toggle to enable force-destruction of S3 Bucket"
  default     = false
}

variable "s3_create_readme" {
  type        = bool
  description = "Toggle creation of `README.md` in root of S3 Bucket"
  default     = false
}

variable "acm_use_default_tags" {
  type        = bool
  description = "Toggle to enable creation of default tags for ACM Certificate, containing Terraform Workspace identifier"
  default     = true
}

variable "acm_tags" {
  type        = map(string)
  description = "Mapping of Tags of ACM Certificate"
  default     = {}
}

variable "acm_enable_certificate_transparency_log" {
  type        = bool
  description = "Toggle to enable a Certificate Transparency Log"
  default     = true
}

variable "route53_zone_id" {
  type        = string
  description = "ID of Route 53 Zone to use for Certificate Validation"
}

variable "cloudfront_origin_access_identity_comment" {
  type        = string
  description = "Comment for CloudFront Origin Access Identity"
  default     = ""
}

variable "cloudfront_enabled" {
  type        = bool
  description = "Toggle to enable CloudFront Distribution"
  default     = true
}

variable "cloudfront_is_ipv6_enabled" {
  type        = bool
  description = "Toggle to enable IPv6 support for CloudFront Distribution"
  default     = true
}

variable "cloudfront_comment" {
  type        = string
  description = "Comment for CloudFront Distribution"
  default     = "Terraform-managed resource"
}

// TODO: turn into variable
variable "cloudfront_default_cache_behavior" {
  type        = map
  description = "Default cache behavior for CloudFront Distribution"
  default     = {}
}

variable "cloudfront_default_root_object" {
  type        = string
  description = "Default Object to return for CloudFront Distribution"
  default     = "index.html"
}

variable "cloudfront_http_version" {
  type        = string
  description = "HTTP version for CloudFront Distribution"
  default     = "http2"
}

variable "cloudfront_price_class" {
  type        = string
  description = "Price class for CloudFront Distribution"
  default     = "PriceClass_100"
}

variable "cloudfront_use_default_tags" {
  type        = bool
  description = "Toggle to enable creation of default tags for CloudFront Distribution, containing Terraform Workspace identifier"
  default     = true
}

variable "cloudfront_tags" {
  type        = map(string)
  description = "Mapping of Tags of CloudFront Distribution"
  default     = {}
}

variable "cloudfront_minimum_protocol_version" {
  type        = string
  description = "Minimum version of SSL protocol to support for this CloudFront Distribution"
  default     = "TLSv1.1_2016"
}

variable "cloudfront_ssl_support_method" {
  type        = string
  description = "HTTPs request serving method for CloudFront Distribution"
  default     = "sni-only"
}

locals {
  default_tags = {
    TerraformManaged   = true
    TerraformWorkspace = terraform.workspace
  }

  // if `use_default_tags` is set to `true`, merge `tags` with `default_tags`
  // otherwise, use user-supplied `tags` mapping
  s3_merged_tags         = var.s3_use_default_tags ? merge(var.s3_tags, local.default_tags) : var.s3_tags
  acm_merged_tags        = var.acm_use_default_tags ? merge(var.acm_tags, local.default_tags) : var.acm_tags
  cloudfront_merged_tags = var.cloudfront_use_default_tags ? merge(var.cloudfront_tags, local.default_tags) : var.cloudfront_tags

  concatenated_records = concat([var.domain_name], var.alternate_domain_names)

  // if `use_prefix` is set to `true`, set `bucket_name` to `null`
  // thereby allowing Terraform to set the `bucket_prefix`
  s3_bucket_name = var.s3_use_prefix ? null : var.s3_bucket_name

  // if `use_prefix` is set to `false`, set `bucket_prefix` to `null`
  // thereby allowing Terraform to set the `bucket_name`
  s3_bucket_prefix = var.s3_use_prefix ? var.s3_bucket_name : null

  s3_origin_id = "S3-${var.s3_bucket_name}"

  cloudfront_origin_access_identity_comment = var.cloudfront_origin_access_identity_comment != "" ? var.cloudfront_origin_access_identity_comment : "Terraform-managed Origin Access Identity for ${var.domain_name}"
}
