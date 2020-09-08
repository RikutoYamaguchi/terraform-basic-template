module "prod" {
  source         = "../../"
  aws_account_id = var.aws_account_id
  service_name   = var.service_name
  main_domain    = var.main_domain
  environment    = "prod"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = {
    "public-1a" = {
      cidr = "10.0.0.0/20",
      az   = "ap-northeast-1a"
    }
    "public-1c" = {
      cidr = "10.0.16.0/20",
      az   = "ap-northeast-1c"
    }
  }
  private_subnets = {
    "private-1a" = {
      cidr = "10.0.32.0/20",
      az   = "ap-northeast-1a"
    }
    "private-1c" = {
      cidr = "10.0.48.0/20",
      az   = "ap-northeast-1c"
    }
  }

  example_api_domain = "api.${var.main_domain}"
}
