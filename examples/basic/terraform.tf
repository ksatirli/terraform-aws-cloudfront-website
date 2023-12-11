terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/5.30.0/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.30.0, < 6.0.0"

      # see https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations
      configuration_aliases = [
        aws.certificate
      ]
    }

    # The Random Provider is solely used to create a random suffix for the S3 Bucket resource.
    # see https://registry.terraform.io/providers/hashicorp/random/3.6.0
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.4.0"
}
