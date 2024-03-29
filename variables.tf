variable "alternate_subdomain_names" {
  type        = list(string)
  description = "The Alternate (Sub)-Domain Names to provide to ACM and CloudFront."
  default     = []
}

variable "cloudfront_cache_policy" {
  type        = string
  description = "The Identifier for a Cache Policy."
  default     = "Managed-CachingOptimized"
}

variable "cloudfront_custom_error_responses" {
  type = list(object({
    error_caching_min_ttl = optional(number)
    error_code            = number
    response_code         = optional(number)
    response_page_path    = optional(string)
  }))

  description = "List of Custom Error Response Element Objects for the distribution."
  default     = [
    # example value only, do not uncomment
    #{
    #  error_code         = 404
    #  response_code      = 404
    #  response_page_path = "/404.html"
    #}
  ]
}

variable "cloudfront_enabled" {
  type        = bool
  description = "Whether the distribution is enabled to accept end user requests for content."
  default     = true
}

variable "cloudfront_default_root_object" {
  type        = string
  description = "The object that you want CloudFront to return when an end user requests the root URL."
  default     = "index.html"
}

variable "cloudfront_http_version" {
  type        = string
  description = "The maximum HTTP version to support on the distribution."
  default     = "http2and3"
}

variable "cloudfront_is_ipv6_enabled" {
  type        = bool
  description = "Whether the IPv6 is enabled for the distribution."
  default     = true
}

variable "cloudfront_minimum_protocol_version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default     = "TLSv1.2_2021"
}

variable "cloudfront_origin_request_policy" {
  type        = string
  description = "The Identifier for an Origin Request Policy."
  default     = "Managed-CORS-S3Origin"
}

variable "cloudfront_price_class" {
  type        = string
  description = "The price class for this distribution."
  default     = "PriceClass_100"
}

variable "cloudfront_response_headers_policy" {
  type        = string
  description = "The Identifier for a Response Headers Policy."
  default     = "Managed-SimpleCORS"
}

variable "cloudfront_retain_on_delete" {
  type        = bool
  description = "Whether to retain (instead of delete) the CloudFront Distribution on `terraform destroy`."
  default     = false
}

variable "cloudfront_ssl_support_method" {
  type        = string
  description = "Specifies how you want CloudFront to serve HTTPS requests."
  default     = "sni-only"
}

variable "domain_name" {
  type        = string
  description = "The Domain Name of the Route53 Zone."
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the bucket."
}

variable "subdomain_name" {
  type        = string
  description = "The Subdomain Name of the Route53 Record."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."

  default = {}
}

locals {
  # if subdomain isn't set, fall back to primary domain (as was the case with v1.0.0 of this module)
  primary_record = var.subdomain_name != "" ? "${var.subdomain_name}.${var.domain_name}" : var.domain_name
}
