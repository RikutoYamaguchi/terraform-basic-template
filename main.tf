provider "aws" {
  region  = "ap-northeast-1"
  version = "~> 3.0"
  profile = var.aws_profile
}

terraform {
  required_version = "0.13.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
