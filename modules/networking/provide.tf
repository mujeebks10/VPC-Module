######## ####### Configure the Terraform Backend ###########
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
    backend "s3" {
    bucket         = "my-terraform-statebucket01"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

}

#### Configure the AWS Provider
provider "aws" {
  region  = "us-east-1" # Specify the AWS region
       # Replace with the name of your AWS CLI profile
}
