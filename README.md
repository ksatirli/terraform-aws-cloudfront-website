# Terraform Module: AWS CloudFront Websites

> Terraform Module for managing AWS CloudFront Websites

## Table of Contents

- [Terraform Module: AWS CloudFront Websites](#terraform-module-aws-cloudfront-websites)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Requirements](#requirements)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
    - [Inputs](#inputs)
    - [Outputs](#outputs)
  - [Author Information](#author-information)
  - [License](#license)

## Overview

![Terraform Module: AWS CloudFront Websites](https://raw.githubusercontent.com/operatehappy/terraform-aws-cloudfront-website/master/overview.png "Terraform Module: AWS CloudFront Websites")

## Requirements

This module requires Terraform version `0.12.0` or newer.

## Dependencies

This module depends on a correctly configured [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html) in your Terraform codebase.

## Usage

Add the module to your Terraform resources like so:

```hcl
module "cloudfront_website" {
  providers = {
    aws.distribution = aws
    // NOTE: ACM Certificates for usage with CloudFront need to be created in the `us-east-1` region, see https://amzn.to/2TW2J16
    aws.global = aws
  }

  source  = "operatehappy/cloudfront-website/aws"
  version = "0.5.0"

  domain_name = "example.com"
  alternate_domain_names = [
    "www.example.com"
  ]

  s3_bucket_name      = "example-website"
  s3_use_prefix       = false
  s3_policy           = ""
  s3_use_default_tags = true
  s3_tags = {
    website = "https://example.com/"
  }

  s3_force_destroy = false
  s3_create_readme = false

  acm_use_default_tags = true
  acm_tags = {
    website = "https://example.com/"
  }

  route53_zone_id = "Z3P5QSUBK4POTI"
}
```

Then, fetch the module from the [Terraform Registry](https://registry.terraform.io/modules/operatehappy/cloudfront-website) using `terraform get`.

### Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| domain_name | Domain name of website | `string` | n/a |
| route53_zone_id | ID of Route 53 Zone to use for Certificate Validation | `string` | n/a |
| s3_bucket_name | Name of S3 Bucket | `string` | n/a |
| acm_enable_certificate_transparency_log | Toggle to enable a Certificate Transparency Log | `bool` | `true` |
| acm_tags | Mapping of Tags of ACM Certificate | `map(string)` | `{}` |
| acm_use_default_tags | Toggle to enable creation of default tags for ACM Certificate, containing Terraform Workspace identifier | `bool` | `true` |
| alternate_domain_names | Alternate Domain Names of Website | `list(string)` | `[]` |
| cloudfront_comment | Comment for CloudFront Distribution | `string` | `"Terraform-managed resource"` |
| cloudfront_default_cache_behavior | Default cache behavior for CloudFront Distribution | `map` | `{}` |
| cloudfront_default_root_object | Default Object to return for CloudFront Distribution | `string` | `"index.html"` |
| cloudfront_enabled | Toggle to enable CloudFront Distribution | `bool` | `true` |
| cloudfront_http_version | HTTP version for CloudFront Distribution | `string` | `"http2"` |
| cloudfront_is_ipv6_enabled | Toggle to enable IPv6 support for CloudFront Distribution | `bool` | `true` |
| cloudfront_minimum_protocol_version | Minimum version of SSL protocol to support for this CloudFront Distribution | `string` | `"TLSv1.1_2016"` |
| cloudfront_origin_access_identity_comment | Comment for CloudFront Origin Access Identity | `string` | `""` |
| cloudfront_price_class | Price class for CloudFront Distribution | `string` | `"PriceClass_100"` |
| cloudfront_ssl_support_method | HTTPs request serving method for CloudFront Distribution | `string` | `"sni-only"` |
| cloudfront_tags | Mapping of Tags of CloudFront Distribution | `map(string)` | `{}` |
| cloudfront_use_default_tags | Toggle to enable creation of default tags for CloudFront Distribution, containing Terraform Workspace identifier | `bool` | `true` |
| region | Region of S3 Bucket | `string` | `null` |
| s3_create_readme | Toggle creation of `README.md` in root of S3 Bucket | `bool` | `false` |
| s3_force_destroy | Toggle to enable force-destruction of S3 Bucket | `bool` | `false` |
| s3_policy | Policy (JSON) Document of S3 Bucket | `string` | `null` |
| s3_tags | Mapping of Tags of S3 Bucket | `map(string)` | `{}` |
| s3_use_default_tags | Toggle to enable creation of default tags for S3 Bucket, containing Terraform Workspace identifier | `bool` | `true` |
| s3_use_prefix | Toggle to use randomly-generated Prefix for Bucket Name | `bool` | `false` |

### Outputs

| Name | Description |
|------|-------------|
| bucket_arn | ARN of the S3 Bucket |
| bucket_hosted_zone_id | Route 53 Hosted Zone ID of the S3 Bucket |
| bucket_id | Identifier of the S3 Bucket |
| certificate_arn | ARN of the ACM Certificate |
| certificate_domain_name | Domain name(s) of the ACM Certificate |
| certificate_id | Identifier of the ACM Certificate |
| distribution_active_trusted_signers | Key Pair IDs that are able to sign private URLs for the CloudFront Distribution |
| distribution_arn | ARN of the CloudFront Distribution |
| distribution_domain_name | Domain Name of the CloudFront Distribution |
| distribution_etag | Identifier of Current Version of the CloudFront Distribution |
| distribution_hosted_zone_id | Route 53 Zone ID for the CloudFront Distribution |
| distribution_id | Identifier for the CloudFront Distribution |
| distribution_in_progress_validation_batches | Number of invalidation batches currently in progress for the CloudFront Distribution |
| distribution_last_modified_time | Date and time of last modification for the CloudFront Distribution |
| distribution_status | Status of the CloudFront Distribution |
| origin_access_identity_etag | Identifier of current version of the Origin Access Identity |
| origin_access_identity_iam_arn | ARN of the Origin Access Identity |
| origin_access_identity_id | Identifier of the CloudFront Distribution |
| origin_access_identity_path | Full path of the Origin Access Identity |
| origin_access_identity_s3_canonical_user_id | Canonical S3 User ID of the Origin Access Identity |
| route53_record_fqdn | Name of the Route 53 Record FQDN |
| route53_record_names | Name of the Route 53 Record Name(s) |

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/terraform-aws-cloudfront-website/graphs/contributors).

Development of this module was sponsored by [Operate Happy](https://github.com/operatehappy).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
