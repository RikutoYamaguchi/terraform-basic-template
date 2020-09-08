data "aws_route53_zone" "main" {
  name = var.main_domain
}

resource "aws_acm_certificate" "wildcard" {
  domain_name = data.aws_route53_zone.main.name
  subject_alternative_names = [
    "*.${var.main_domain}"
  ]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  validation_options_by_domain_name = {
    for opt in aws_acm_certificate.wildcard.domain_validation_options : opt.domain_name => opt
  }
}

# for ACM
resource "aws_route53_record" "wildcard" {
  name = replace(lookup(local.validation_options_by_domain_name, data.aws_route53_zone.main.name, values(local.validation_options_by_domain_name)[0]).resource_record_name, format(".%s.", data.aws_route53_zone.main.name), "")
  type = lookup(local.validation_options_by_domain_name, data.aws_route53_zone.main.name, values(local.validation_options_by_domain_name)[0]).resource_record_type
  records = [
    lookup(local.validation_options_by_domain_name, data.aws_route53_zone.main.name, values(local.validation_options_by_domain_name)[0]).resource_record_value
  ]
  zone_id = data.aws_route53_zone.main.id
  ttl     = 60
}

# It's only validation. Not create resources.
resource "aws_acm_certificate_validation" "wildcard" {
  certificate_arn         = aws_acm_certificate.wildcard.arn
  validation_record_fqdns = [aws_route53_record.wildcard.fqdn]
}
