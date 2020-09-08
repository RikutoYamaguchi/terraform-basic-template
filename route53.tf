data "aws_route53_zone" "main" {
  name = var.main_domain
}

resource "aws_route53_record" "example_api" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.example_api_domain
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = module.example_api.dns_name
    zone_id                = module.example_api.zone_id
  }
}

data "aws_acm_certificate" "wildcard" {
  domain   = var.main_domain
  statuses = ["PENDING_VALIDATION", "ISSUED"]
}
