resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

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
