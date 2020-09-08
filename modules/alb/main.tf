# -------------------------------------------------------------
# Security Groups
# -------------------------------------------------------------
module "http_sg" {
  source      = "../security_group"
  name        = "${var.name}-http"
  environment = var.environment
  vpc_id      = var.vpc_id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "../security_group"
  name        = "${var.name}-https"
  environment = var.environment
  vpc_id      = var.vpc_id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "http_redirect_sg" {
  source      = "../security_group"
  name        = "${var.name}-http-redirect"
  environment = var.environment
  vpc_id      = var.vpc_id
  port        = 8080
  cidr_blocks = ["0.0.0.0/0"]
}

# -------------------------------------------------------------
# S3
# -------------------------------------------------------------
resource "aws_s3_bucket" "default" {
  bucket = "${var.service_name}-${var.name}"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }

  tags = {
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "s3_put_object" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.default.id}/*"]

    principals {
      # ap-northeast-1のID
      # https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/classic/enable-access-logs.html
      identifiers = ["582318560864"]
      type        = "AWS"
    }
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.default.id
  policy = data.aws_iam_policy_document.s3_put_object.json
}

# -------------------------------------------------------------
# ALB
# -------------------------------------------------------------
resource "aws_lb" "default" {
  name                             = var.name
  load_balancer_type               = "application"
  internal                         = false
  idle_timeout                     = 60
  enable_cross_zone_load_balancing = true

  subnets = var.public_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.default.id
    enabled = true
  }

  security_groups = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
    module.http_redirect_sg.security_group_id,
  ]

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.default.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "It's HTTPS protocol access"
      status_code  = "200"
    }
  }
}

//resource "aws_lb_listener_rule" "example" {
//  listener_arn = aws_lb_listener.https.arn
//  priority = 100
//
//  action {
//    type = "forward"
//    target_group_arn = aws_lb_target_group.example.arn
//  }
//
//  condition {
//    path_pattern {
//      values = ["/*"]
//    }
//  }
//}
//
