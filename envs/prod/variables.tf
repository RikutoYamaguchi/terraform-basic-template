variable "aws_account_id" {
  description = "The aws account id."
  type        = string
}

variable "service_name" {
  description = "The name of your service. It's used for some resource names."
  type        = string
}

variable "main_domain" {
  description = "The domain for your service."
  type        = string
}
