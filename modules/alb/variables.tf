variable "name" {
  description = "The name of the loadbalancer and to use for base name of related resources."
  type        = string
}

variable "environment" {
  description = "The name of the environment to use for the tag."
  type        = string
}

variable "vpc_id" {
  description = "The vpc id for loadbalancer."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet ids to place the loadbalancer in."
  type        = list(string)
}

variable "certificate_arn" {
  description = "The certificate arn for listener of loadbalancer."
  type        = string
}

variable "service_name" {
  description = "The name of your service. It's used for name of the s3 bucket."
  type        = string
}
