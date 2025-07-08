terraform {
  cloud {
    organization = "Terraform-nauka"    # Twoja organizacja w Terraform Cloud
    workspaces {
      name = "Praca-magisterska"      # Dokładna nazwa Twojego workspace’u
    }
  }

  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region         # ustawimy w zmiennej
}


