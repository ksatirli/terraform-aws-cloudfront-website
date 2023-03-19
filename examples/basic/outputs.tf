output "aws_acm_certificate_validation" {
  description = "Exported Attributes for `module.acm_certificate.aws_acm_certificate_validation`."
  value       = module.website.aws_acm_certificate_validation
}

output "aws_cloudfront_distribution" {
  description = "Exported Attributes for `aws_cloudfront_distribution`."
  value       = module.website.aws_cloudfront_distribution
}

output "aws_route53_record" {
  description = "Exported Attributes for `aws_route53_record.main`."
  value       = module.website.aws_route53_record
}

output "aws_s3_bucket" {
  description = "Exported Attributes for `aws_s3_bucket.main`."
  value       = module.website.aws_s3_bucket
}

output "aws_s3_bucket_acl" {
  description = "Exported Attributes for `aws_s3_bucket_acl.main`."
  value       = module.website.aws_s3_bucket_acl
}

output "aws_s3_bucket_public_access_block" {
  description = "Exported Attributes for `aws_s3_bucket_public_access_block.main`."
  value       = module.website.aws_s3_bucket_public_access_block
}

output "aws_s3_bucket_policy" {
  description = "Exported Attributes for `aws_s3_bucket_policy.main`."
  value       = module.website.aws_s3_bucket_policy
}
