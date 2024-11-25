module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  bucket = var.inputs.bucket
  acl    = var.inputs.acl

  control_object_ownership = var.inputs.control_object_ownership
  object_ownership         = var.inputs.object_ownership

  versioning = {
    enabled = var.inputs.versioning.enabled
  }
}
