terraform {
  source = "git::https://github.com/PlayQ-DevOps/terraform-playq-poc.git//terraform/service-c?ref=v0.0.1"
}

inputs = {
  acl                      = "private"
  bucket                   = "dosb-service-c-bucket"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
}
