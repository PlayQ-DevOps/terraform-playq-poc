terraform {
  source = "git::git@github.com:PlayQ-DevOps/terraform-playq-poc.git//terraform/service-a?ref=v0.0.1"
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
