terraform {
  source = "git::git@github.com:PlayQ-DevOps/terraform-playq-poc.git//terraform/service-b?ref=v0.0.1"
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
