resource "aws_cloudfront_origin_access_control" "s3CDN" {
  name                              = "S3 access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3CDN" {
  enabled             = true
  aliases             = [aws_s3_bucket.s3.bucket]
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.s3.bucket
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    min_ttl     = 86400
    default_ttl = 604800
    max_ttl     = 31536000

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100"

  origin {
    domain_name              = aws_s3_bucket.s3.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.s3.bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.s3CDN.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cdn.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  depends_on = [aws_s3_bucket.s3, aws_acm_certificate.cdn]
}