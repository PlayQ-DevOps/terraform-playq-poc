terraform {
  source = "../../../terraform/service-c"
}

inputs = {
  acl                      = "private"
  bucket                   = "staging-service-c-bucket"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
}
