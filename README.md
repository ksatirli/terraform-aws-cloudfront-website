# AWS: S3-backed CloudFront Distribution

This Terraform Module provisions an S3-backed CloudFront Distribution for HTTP serving.

## Table of Contents

<!-- TOC -->
* [AWS: S3-backed CloudFront Distribution](#aws--s3-backed-cloudfront-distribution)
  * [Table of Contents](#table-of-contents)
  * [Overview](#overview)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Overview

![Terraform Module: AWS CloudFront Websites](https://raw.githubusercontent.com/operatehappy/terraform-aws-cloudfront-website/master/overview.png "Terraform Module: AWS CloudFront Websites")

## Requirements

* Amazon Web Services (AWS) [Account](https://aws.amazon.com/account/)
* Terraform `1.3.x` or newer.

## Usage

For examples, see the [./examples](https://github.com/ksatirli/terraform-aws-cloudfront-website/tree/main/examples/) directory.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alternate_domain_names | The Alternate Domain Names to provide to ACM and CloudFront. | `list(string)` | n/a | yes |
| domain_name | The Domain Name of the Route53 Zone. | `string` | n/a | yes |
| s3_bucket_name | The name of the bucket. | `string` | n/a | yes |
| cloudfront_cache_policy | The Identifier for a Cache Policy. | `string` | `"Managed-CachingOptimized"` | no |
| cloudfront_default_root_object | The object that you want CloudFront to return when an end user requests the root URL. | `string` | `"index.html"` | no |
| cloudfront_enabled | Whether the distribution is enabled to accept end user requests for content. | `bool` | `true` | no |
| cloudfront_http_version | The maximum HTTP version to support on the distribution. | `string` | `"http2and3"` | no |
| cloudfront_is_ipv6_enabled | Whether the IPv6 is enabled for the distribution. | `bool` | `true` | no |
| cloudfront_minimum_protocol_version | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | `string` | `"TLSv1.2_2021"` | no |
| cloudfront_origin_request_policy | The Identifier for an Origin Request Policy. | `string` | `"Managed-CORS-S3Origin"` | no |
| cloudfront_price_class | The price class for this distribution. | `string` | `"PriceClass_100"` | no |
| cloudfront_response_headers_policy | The Identifier for a Response Headers Policy. | `string` | `"Managed-SimpleCORS"` | no |
| cloudfront_retain_on_delete | Wether to retain (instead of delete) the CloudFront Distribution on `terraform destroy`. | `bool` | `false` | no |
| cloudfront_ssl_support_method | Specifies how you want CloudFront to serve HTTPS requests. | `string` | `"sni-only"` | no |
| s3_bucket_acl | The canned ACL to apply to the Bucket. | `string` | `"private"` | no |
| tags | A map of tags to assign to all resources. | `map(string)` | `{}` | no |

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

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/terraform-aws-cloudfront-website/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
