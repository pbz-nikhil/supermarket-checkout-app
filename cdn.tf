resource "aws_cloudfront_distribution" "cdn_distribution" {
  depends_on = [aws_alb.app_alb]
  origin {
    domain_name = aws_alb.app_alb.dns_name
    origin_id   = aws_alb.app_alb.dns_name
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled  = true
  comment  = "CDN distribution for Supermarket checkout"

  default_cache_behavior {
    target_origin_id = aws_alb.app_alb.dns_name
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    compress         = true
    default_ttl      = 0
    max_ttl          = 3600
    min_ttl          = 0
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
    
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

output "cdn_url" {
  value = aws_cloudfront_distribution.cdn_distribution.domain_name
}
