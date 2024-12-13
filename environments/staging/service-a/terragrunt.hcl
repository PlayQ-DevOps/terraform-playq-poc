terraform {
  source = "../../../terraform/service-a"
}

inputs = {
  acl                      = "private"
  bucket                   = "staging-service-a-bucket"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
}
