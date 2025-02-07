output "cdn_domain" {
  value       = aws_cloudfront_distribution.s3CDN.domain_name
  description = "CloudFront domain name access"
}

output "s3_name" {
  value       = aws_s3_bucket.s3.id
  description = "S3 name"
}