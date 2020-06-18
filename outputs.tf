output "bucket_arn" {
  value       = module.s3_bucket.arn
  description = "ARN of the S3 Bucket"
}

output "bucket_id" {
  value       = module.s3_bucket.id
  description = "Identifier of the S3 Bucket"
}

output "bucket_hosted_zone_id" {
  value       = module.s3_bucket.hosted_zone_id
  description = "Route 53 Hosted Zone ID of the S3 Bucket"
}

output "certificate_arn" {
  value       = module.acm_certificate.arn
  description = "ARN of the ACM Certificate"
}

output "certificate_id" {
  value       = module.acm_certificate.id
  description = "Identifier of the ACM Certificate"
}

output "certificate_domain_name" {
  value       = module.acm_certificate.domain_name
  description = "Domain name(s) of the ACM Certificate"
}

output "origin_access_identity_id" {
  value       = aws_cloudfront_origin_access_identity.this.id
  description = "Identifier of the CloudFront Distribution"
}

output "origin_access_identity_path" {
  value       = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
  description = "Full path of the Origin Access Identity"
}

output "origin_access_identity_etag" {
  value       = aws_cloudfront_origin_access_identity.this.etag
  description = "Identifier of current version of the Origin Access Identity"
}

output "origin_access_identity_iam_arn" {
  value       = aws_cloudfront_origin_access_identity.this.iam_arn
  description = "ARN of the Origin Access Identity"
}

output "origin_access_identity_s3_canonical_user_id" {
  value       = aws_cloudfront_origin_access_identity.this.s3_canonical_user_id
  description = "Canonical S3 User ID of the Origin Access Identity"
}

// TODO: cloudfront outputs
output "distribution_id" {
  value       = aws_cloudfront_distribution.this.id
  description = "Identifier for the CloudFront Distribution"
}

output "distribution_arn" {
  value       = aws_cloudfront_distribution.this.arn
  description = "ARN of the CloudFront Distribution"
}

output "distribution_status" {
  value       = aws_cloudfront_distribution.this.status
  description = "Status of the CloudFront Distribution"
}

output "distribution_active_trusted_signers" {
  value       = aws_cloudfront_distribution.this.active_trusted_signers
  description = "Key Pair IDs that are able to sign private URLs for the CloudFront Distribution"
}

output "distribution_domain_name" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "Domain Name of the CloudFront Distribution"
}

output "distribution_last_modified_time" {
  value       = aws_cloudfront_distribution.this.last_modified_time
  description = "Date and time of last modification for the CloudFront Distribution"
}

output "distribution_in_progress_validation_batches" {
  value       = aws_cloudfront_distribution.this.in_progress_validation_batches
  description = "Number of invalidation batches currently in progress for the CloudFront Distribution"
}

output "distribution_etag" {
  value       = aws_cloudfront_distribution.this.etag
  description = "Identifier of Current Version of the CloudFront Distribution"
}

output "distribution_hosted_zone_id" {
  value       = aws_cloudfront_distribution.this.hosted_zone_id
  description = "Route 53 Zone ID for the CloudFront Distribution"
}

//output "policy_document_json" {
//  value       = aws_iam_policy_document.this.json
//  description = "IAM Policy Document for S3 Bucket Policy (in JSON Format)"
//}

output "route53_record_names" {
  value       = aws_route53_record.this[*].name
  description = "Name of the Route 53 Record Name(s)"
}

output "route53_record_fqdn" {
  value       = aws_route53_record.this[*].fqdn
  description = "Name of the Route 53 Record FQDN"
}
