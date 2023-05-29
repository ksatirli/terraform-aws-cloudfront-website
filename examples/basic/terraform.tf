terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/4.67.0/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0, < 6.0.0"

      # see https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations
      configuration_aliases = [
        aws.certificate
      ]
    }

    # The Random Provider is solely used to create a random suffix for the S3 Bucket resource.
    # see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.4.0"
}
