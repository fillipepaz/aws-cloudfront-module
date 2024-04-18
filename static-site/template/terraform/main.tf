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
    key    = "site-estatico/terraform.tfstate"
    region = "us-east-1"
  }
}


module "cloudfront" {
    //source = "git@github.com:fillipepaz/aws-cloudfront-module.git//static-site"
    source = "../"
    accountId="704151674151"
    repoNameAndOrg="fillipepaz/example-site"
    bucketName="demonstration-bucket-test"
    project="PlatformEnginneeringProject" 
    
}