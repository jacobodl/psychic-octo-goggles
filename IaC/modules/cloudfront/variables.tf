variable "bucket_cdn" {
  type        = string
  description = "bucket cdn sarbo"

}

variable "stage" {
  description = "Stage del ambiente"
  type        = string
}

variable "domain" {
  description = "dominio de cdn"
  type        = string

}

variable "certificate_arn" {
  description = "ARN del certificado de dominio"
  type        = string

}

variable "zone_id" {
  description = "ID de la zona de Route 53"
  type        = string
  
}

variable "bucket_cdn_name" {
    description = "Nombre del bucket de cdn"
    type        = string
}

variable "default_cache" {
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