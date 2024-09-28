variable "region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "Profile de AWS"
  type        = string
}

variable "stage" {
  description = "Stage de AWS"
  type        = string
}

variable "bucket_cdn" {
  type        = string
  description = "bucket cdn sarbo"

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