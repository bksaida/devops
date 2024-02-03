terraform {
  backend "s3" {
    bucket         = "terraform-state-storage"
    key            = "terraform.tfstate"
    region         = "us-west-1"  
    # dynamodb_table = "terraform_locks" 
  }
}


provider "aws" {
  region = "us-west-1" 
  # Add any additional configuration for AWS provider as needed
}




