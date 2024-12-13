terraform {
  source = "../../../terraform/service-a"
}

inputs = {
  acl                      = "private"
  bucket                   = "dev-service-a-bucket"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
}
