# 1. Terraform Settings Block
terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    required_version = ">= 1.2.0"
}

# 2. AWS Provider Configuration
provider "aws" {
    region = "us-east-1"
}

# 3. AWS S3 Bucket Resourse
resource "aws_s3_bucket" "static_site" {
    bucket = "johann-s3-pipeline-website-2026"
}