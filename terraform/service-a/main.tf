resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  bucket = "${var.inputs.bucket}-${random_string.suffix.result}"
  acl    = var.inputs.acl

  control_object_ownership = var.inputs.control_object_ownership
  object_ownership         = var.inputs.object_ownership

  versioning = {
    enabled = var.inputs.versioning.enabled
  }
}
