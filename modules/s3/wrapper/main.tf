module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  bucket = var.input.bucket
  acl    = var.input.acl

  control_object_ownership = var.input.control_object_ownership
  object_ownership         = var.input.object_ownership

  versioning = {
    enabled = var.input.versioning.enabled
  }
}
