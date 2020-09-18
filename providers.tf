provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"
}
