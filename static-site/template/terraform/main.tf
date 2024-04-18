terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.45.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "versioning-terraform-home"
    key    = "site-estatico/${{ values.environment }}/${{ values.project }}/terraform.tfstate"
    region = "us-east-1"
  }
}


module "cloudfront" {
    source = "git@github.com:fillipepaz/aws-cloudfront-module.git//static-site"
    accountId="${{ values.account }}"
    repoNameAndOrg="${{ values.org }}/${{ values.repository }}"
    bucketName="bucket-${{ values.project }}"
    project="${{ values.project }}" 
    
}