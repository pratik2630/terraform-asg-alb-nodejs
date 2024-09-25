# Output the DNS name (URL) of the ALB
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.example.dns_name
}
