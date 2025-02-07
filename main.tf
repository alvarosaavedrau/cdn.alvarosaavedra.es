terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.30.0"
    }
  }

  required_version = ">=1.9.5"

  backend "s3" {
    bucket       = "alvarosaavedra-tfstate"
    key          = "terraform/aws/cdn/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region                   = var.aws_region_name
  shared_credentials_files = var.credentials_file_location
}