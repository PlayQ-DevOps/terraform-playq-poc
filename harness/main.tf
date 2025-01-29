# Organization: Platform Infrastructure

# Project: DevOps Sandbox

# Project: Development

# Project: Staging

# Project: Production

# Workflows (Workspace, Pipeline, and Trigger)

locals {
  #main_workflows = var.environments.devopssandbox.workflows
  #release_workflows = flatten([
  #  var.environments.development.workflows,
  #  var.environments.staging.workflows
  #])
}

module "main_workflow" {
  for_each = { for workflow in var.environments.devopssandbox.workflows : workflow.name => workflow }

  source = "./modules/harness_main_workflow"

  git_ref    = var.environments.devopssandbox.git_ref
  org_id     = var.environments.devopssandbox.org_id
  project_id = var.environments.devopssandbox.project_id

  name                = each.value.name
  changed_files       = each.value.changed_files
  module_file_path    = each.value.module_file_path
  variables_file_path = each.value.variables_file_path
}

# module "release_workflow" {
#   for_each = { for workflow in local.release_workflows : workflow.name => workflow }
# 
#   source = "./modules/harness_release_workflow"
# 
#   name                = each.value.name
#   changed_files_regex = each.value.changed_files_regex
# }

