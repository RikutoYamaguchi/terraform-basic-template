variable "name" {
  description = "The security group name."
  type        = string
}
variable "environment" {
  description = "The name of the environment to use for the tag."
  type        = string
}
variable "vpc_id" {
  description = "The vpc id for security group."
  type        = string
}
variable "port" {
  description = "The port for security group ingress."
  type        = number
}
variable "cidr_blocks" {
  description = "The cidr blocks for security group ingress."
  type        = list(string)
}
