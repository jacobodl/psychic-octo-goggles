stage                       = "dev"
region                      = "us-east-1"
profile                     = "jacobos_lab"
procesador                  = "mcdgt"
vpc_cidr                    = "10.0.0.0/16"
serverless_bucket_name      = "sarbo-serverless-deployments"
anp6_serverless_bucket_name = "sarbo-anp6-serverless-deployments"
ec2_ami_id                  = "ami-0230bd60aa48260c6"
ec2_instance_type           = "t2.medium"
azs                         = ["us-east-1a", "us-east-1b", "us-east-1c"]
database_subnets            = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets              = ["10.0.10.0/24", "10.0.11.0/24"]
containers_subnets          = ["10.0.20.0/22", "10.0.24.0/22"]
sarbo_domain            = "jacobo-tech.com"
bucket_frontend         = "sarbo-frontend"
bucket_sarbo_serverless = "sarbo-serverless-deployments"
lambda_authorizer_arn   = "arn: arn:aws:lambda:us-east-1:365912441042:function:sarbo-userManagement-qa-authorizer"
bucket_cdn              = "sarbo-cdn"
cdn_cache = {
  min_ttl     = 10
  default_ttl = 7200
  max_ttl     = 86400
}
frontend_cache = {
  min_ttl     = 0
  default_ttl = 0
  max_ttl     = 0
}

vpc_endpoints = {
  api_gateway     = { create = false, type = "Interface" }
  s3              = { create = true, type = "Gateway" }
  ecr_api         = { create = true, type = "Interface" }
  ecr_dkr         = { create = true, type = "Interface" }
  cloudwatch      = { create = true, type = "Interface" }
  ssm             = { create = true, type = "Interface" }
  secrets_manager = { create = true, type = "Interface" }
  lambda          = { create = true, type = "Interface" }
  sqs             = { create = true, type = "Interface" }
  dynamodb        = { create = true, type = "Gateway" }
}

nat_gateway_config = {
  enable_nat_gateway = true
  single_nat_gateway = true
}

autoscaling = {
  min_capacity       = 1
  max_capacity       = 3
  desired_count      = 1
  target_cpu         = 90
  scale_in_cooldown  = 60
  scale_out_cooldown = 60
}
