terraform {
  source = "../../../terraform/service-b"
}

inputs = {
  acl                      = "private"
  bucket                   = "dev-service-b-bucket"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
}
