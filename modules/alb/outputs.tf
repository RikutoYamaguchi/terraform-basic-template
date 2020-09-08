output "id" {
  description = "The id of created loadbalancer."
  value       = aws_lb.default.id
}

output "dns_name" {
  description = "The dns name of created loadbalancer."
  value       = aws_lb.default.dns_name
}

output "zone_id" {
  description = "The zone id of created loadbalancer."
  value       = aws_lb.default.zone_id
}
