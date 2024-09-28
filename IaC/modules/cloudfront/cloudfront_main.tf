# Crear un Origin Access Identity para CloudFront
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI para acceso a S3"
}

# Actualizar la política del bucket de S3 para permitir acceso al OAI
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_cdn_name

  policy = jsonencode({
    Statement = [
      {
        Action    = "s3:GetObject",
        Effect    = "Allow",
        Resource  = "arn:aws:s3:::${var.bucket_cdn_name}/*",
        Principal = { AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.oai.id}" }
      },
    ]
  })
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.bucket_cdn
    origin_id   = var.bucket_cdn_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  aliases = ["${var.domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_cdn_name


    min_ttl     = var.default_cache.min_ttl
    default_ttl = var.default_cache.default_ttl
    max_ttl     = var.default_cache.max_ttl

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_All"

  custom_error_response {
    error_code            = 404
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 403
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 0
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# Crear un registro A (Alias) que apunte al CloudFront
resource "aws_route53_record" "cf_alias" {
  zone_id = var.zone_id
  name    = var.domain # O usa un subdominio como "www.tu-dominio.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
