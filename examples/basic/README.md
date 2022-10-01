# Example: `basic`

This is a _basic_ example of the `terraform-aws-cloudfront-website` module.

> **Note**
> The example code shown in [./main.tf](./main.tf) is provided for illustration purposes only.
> It will NOT complete successfully, unless `domain.example` is replaced with a publicly routed domain.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| route53_zone_name | Hosted Zone Name of the desired Hosted Zone. | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| aws_acm_certificate | Exported Attributes for `module.acm_certificate.aws_acm_certificate`. |
| aws_acm_certificate_validation | Exported Attributes for `module.acm_certificate.aws_acm_certificate_validation`. |
| aws_cloudfront_distribution | Exported Attributes for `aws_cloudfront_distribution`. |
| aws_route53_record | Exported Attributes for `aws_route53_record.main`. |
| aws_s3_bucket | Exported Attributes for `aws_s3_bucket.main`. |
| aws_s3_bucket_acl | Exported Attributes for `aws_s3_bucket_acl.main`. |
| aws_s3_bucket_policy | Exported Attributes for `aws_s3_bucket_policy.main`. |
| aws_s3_bucket_public_access_block | Exported Attributes for `aws_s3_bucket_public_access_block.main`. |
<!-- END_TF_DOCS -->
