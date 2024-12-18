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

# Automatically find the root terragrunt.hcl and inherit its
# configuration

# The include block tells Terragrunt to use the exact same Terragrunt
# configuration from the root.hcl file specified via the path parameter. It
# behaves exactly as if you had copy/pasted the OpenTofu/Terraform configuration
# from the included file generate configuration into mysql/terragrunt.hcl, but
# this approach is much easier to maintain!
# 
# The next time you run terragrunt, it will automatically configure all the
# settings for the backend, if they aren’t configured already, by calling
# tofu/terraform init.
# 
# The terragrunt.hcl files above use two Terragrunt built-in functions:
# find_in_parent_folders(): This function returns the absolute path to the first
# file it finds in the parent folders above the current unit named something. In
# the example above, the call to find_in_parent_folders("root.hcl") in
# mysql/terragrunt.hcl will return /your-root-folder/root.hcl. This way, you
# don’t have to hard code the path parameter in every module.
# 
# path_relative_to_include(): This function returns the relative path between
# the unit and the path specified in its include block. We typically use this in
# a root root.hcl file so that each unit stores its OpenTofu/Terraform state at
# a different key. For example, the mysql unit will have its key parameter
# resolve to mysql/tofu.tfstate and the frontend-app module will have its key
# parameter resolve to frontend-app/tofu.tfstate.
include "root" {
  path = find_in_parent_folders("root.hcl")
}
