terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  required_version = ">= 1.8"
}

provider "aws" {
  region = "us-east-1"
}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

# FEATURE
module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  bucket = "${var.bucket}-${random_string.suffix.result}"
  acl    = var.acl

  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  versioning = {
    enabled = var.versioning.enabled
  }
}
