
data "aws_acm_certificate" "app_domain_cert" {
  domain       = "app.${var.domain}"
  most_recent  = true  # Esto seleccionará el certificado más reciente si hay varios
  statuses     = ["ISSUED"]  # Filtra por certificados que ya estén emitidos
}

#crea bucket para el cdn
module "frontend_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "aws-community-day-${var.stage}-frontend"
}

output "bucket_cdn" {
  value = module.frontend_bucket.s3_bucket_id

}

module "frontend_cloudfront" {
  source          = "./modules/cloudfront"
  stage           = var.stage
  bucket_cdn      = module.frontend_bucket.s3_bucket_bucket_domain_name
  bucket_cdn_name = module.frontend_bucket.s3_bucket_id
  domain          = "app.${var.domain}"
  certificate_arn = data.aws_acm_certificate.app_domain_cert.arn
  zone_id         = var.hosted_zone
  default_cache   = var.cdn_cache
}