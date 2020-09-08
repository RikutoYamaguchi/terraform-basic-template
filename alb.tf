module "example_api" {
  source            = "./modules/alb"
  certificate_arn   = data.aws_acm_certificate.wildcard.arn
  name              = "alb-${var.environment}-example-api"
  public_subnet_ids = [for k, v in aws_subnet.public : v.id]
  vpc_id            = aws_vpc.default.id
  environment       = var.environment
  service_name      = var.service_name
}
