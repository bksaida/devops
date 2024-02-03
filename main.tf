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



# Define input variables
variable "instance_size" {
  description = "The size of the instance (e.g., t2.micro)"
  type        = string
  default     = "t2.micro" # size
}

variable "virtual_network_cidr" {
  description = "The CIDR block for the virtual network"
  type        = string
  default     = "10.0.0.0/16" # Default CIDR block for virtual network
}


module "example_instance" {
  source  = "./example-module"
  # Other module configuration settings
}

output "instance_public_ip" {
  value = module.example_instance.public_ip_address
}

output "instance_connection_details" {
  value = module.example_instance.connection_details
}
