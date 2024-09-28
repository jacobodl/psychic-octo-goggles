data "aws_ssm_parameter" "cdn_domain_parameter" {
  name = "/simposio/cdn/domain"
}

data "aws_ssm_parameter" "cdn_certificate_arn" {
  name = "/simposio/cdn/certificate_arn"
}

data "aws_ssm_parameter" "cdn_hosted_zone" {
  name = "/simposio/cdn/hosted_zone"
}

#crea bucket para el cdn
module "frontend_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "simposio-uvg-cdn"

  tags = {
    Environment = var.stage
  }
}

output "bucket_cdn" {
  value = module.frontend_bucket.s3_bucket_id

}

module "frontend_cloudfront" {
  source          = "../modules/cloudfront"
  stage           = var.stage
  bucket_cdn      = module.frontend_bucket.s3_bucket_bucket_domain_name
  bucket_cdn_name = module.frontend_bucket.s3_bucket_id
  domain          = data.aws_ssm_parameter.cdn_domain_parameter.value
  certificate_arn = data.aws_ssm_parameter.cdn_certificate_arn.value
  zone_id         = data.aws_ssm_parameter.cdn_hosted_zone.value
  default_cache   = var.cdn_cache
}