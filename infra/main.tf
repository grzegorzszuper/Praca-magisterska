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

# Na początek testowo: utworzymy bucket S3 na logi
resource "aws_s3_bucket" "logs" {
  bucket         = "thesis-logs-${var.env}"
  force_destroy  = true           # by móc go później łatwo usuwać
}

output "s3_bucket_name" {
  value = aws_s3_bucket.logs.id
}

provider "aws" {
  region = var.aws_region         # ustawimy w zmiennej
}


