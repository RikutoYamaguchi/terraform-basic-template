variable "aws_account_id" {
  description = "The aws account id."
  type        = string
}

variable "aws_profile" {
  description = "The profile you want to use."
  type        = string
  default     = "default"
}

variable "environment" {
  description = "The environment name for network. This is used for all resources tags.Name."
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

variable "vpc_cidr" {
  description = "The cidr for vpc."
  type        = string
}

variable "public_subnets" {
  description = "List of arguments for subnet for public subnets."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "List of arguments for subnet for public subnets."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "example_api_domain" {
  description = "The domain for example api."
  type        = string
}

