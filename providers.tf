terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.34.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "terraformUser"
}

# Create a VPC
# resource "aws_vpc" "terraform_demo_vpc" {
#   cidr_block = "10.0.0.0/16"
# }
