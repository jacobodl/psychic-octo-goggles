terraform {
  backend "s3" {
    bucket         = "simposio-terraform-state"
    key            = "terraform-state/ec2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "simposio-terraform-block"
  }
}
