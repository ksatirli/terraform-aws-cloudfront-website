output "aws_acm_certificate" {
  description = "Exported Attributes for `module.acm_certificate.aws_acm_certificate`."
  sensitive   = true
  value       = module.acm_certificate.aws_acm_certificate
}

output "aws_acm_certificate_validation" {
  description = "Exported Attributes for `module.acm_certificate.aws_acm_certificate_validation`."
  value       = module.acm_certificate.aws_acm_certificate_validation
}

output "aws_cloudfront_distribution" {
  description = "Exported Attributes for `aws_cloudfront_distribution`."
  value       = aws_cloudfront_distribution.main
}

output "aws_route53_record" {
  description = "Exported Attributes for `aws_route53_record.main`."
  value       = aws_route53_record.main
}

output "aws_s3_bucket" {
  description = "Exported Attributes for `aws_s3_bucket.main`."
  value       = aws_s3_bucket.main
}

output "aws_s3_bucket_acl" {
  description = "Exported Attributes for `aws_s3_bucket_acl.main`."
  value       = aws_s3_bucket_acl.main
}

output "aws_s3_bucket_public_access_block" {
  description = "Exported Attributes for `aws_s3_bucket_public_access_block.main`."
  value       = aws_s3_bucket_public_access_block.main
}

output "aws_s3_bucket_policy" {
  description = "Exported Attributes for `aws_s3_bucket_policy.main`."
  value       = aws_s3_bucket_policy.main
}
