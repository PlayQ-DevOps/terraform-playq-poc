terraform {
  source = "git::https://github.com/PlayQ-DevOps/terraform-playq-poc.git//terraform/service-a?ref=v0.0.1"
}

inputs = {
  acl                      = "private"
  bucket                   = "dosb-service-a-bucket"
  control_object_ownership = false
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
}
