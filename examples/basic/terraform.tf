terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/4.33.0/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.33.0, < 5.0.0"

      # see https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations
      configuration_aliases = [
        aws.certificate
      ]
    }

    # The Random Provider is solely used to create a random suffix for the S3 Bucket resource.
    # see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.3.0"
}
