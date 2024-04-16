

locals {
  s3_origin_id = "${var.bucketName}-S3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.description
  default_root_object = "index.html"

  

  aliases = var.cnameList

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

 
  


  

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"]
    }
  }

  tags = {
    Environment = "production"
    Project = var.project
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}