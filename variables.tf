variable "aws_region_name" {
  type        = string
  description = "Region where the AWS resources will be created"
}

variable "credentials_file_location" {
  type        = list(string)
  description = "Path to the shared credentials file for AWS"
}

variable "domain_name" {
  type        = string
  description = "Domain name to use"
}