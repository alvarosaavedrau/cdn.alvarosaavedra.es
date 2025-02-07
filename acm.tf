resource "aws_acm_certificate" "cdn" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}