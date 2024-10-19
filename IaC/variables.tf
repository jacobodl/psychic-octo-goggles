variable "stage" {
  description = "Stage de AWS"
  type        = string
}

variable "domain" {
  type        = string
  description = "Dominio del CDN"
  
}

variable "hosted_zone" {
  type        = string
  description = "Zona de DNS del dominio"
  
}

variable "cdn_cache" {
  description = "Default cache configuration for CloudFront"
  type = object({
    min_ttl     = number
    default_ttl = number
    max_ttl     = number
  })
  default = {
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }
}