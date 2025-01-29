# Organization
resource "harness_platform_organization" "organization" {
  identifier = "POC_Platform_Infra"
  name       = "POC Platform Infra"
}

# Projects
resource "harness_platform_project" "project" {
  for_each = var.environments

  identifier = each.key
  name       = each.key
  org_id     = harness_platform_organization.organization.id
}

# Workflows (Workspace, Pipeline, and Trigger)
module "dosb_workflow" {
  for_each = { for workflow in var.environments.devopssandbox.workflows : workflow.name => workflow }

  source = "./modules/harness_main_workflow"

  git_ref             = var.environments.devopssandbox.git_ref
  org_id              = harness_platform_organization.organization.id
  project_id          = harness_platform_project.project["devopssandbox"].id
  name                = each.value.name
  changed_files       = each.value.changed_files
  module_file_path    = each.value.module_file_path
  variables_file_path = each.value.variables_file_path
}

module "dev_workflow" {
  for_each = { for workflow in var.environments.development.workflows : workflow.name => workflow }

  source = "./modules/harness_release_workflow"

  git_ref             = var.environments.development.git_ref
  org_id              = harness_platform_organization.organization.id
  project_id          = harness_platform_project.project["development"].id
  name                = each.value.name
  changed_files       = each.value.changed_files
  module_file_path    = each.value.module_file_path
  variables_file_path = each.value.variables_file_path
}


module "stg_workflow" {
  for_each = { for workflow in var.environments.staging.workflows : workflow.name => workflow }

  source = "./modules/harness_release_workflow"

  git_ref             = var.environments.staging.git_ref
  org_id              = harness_platform_organization.organization.id
  project_id          = harness_platform_project.project["staging"].id
  name                = each.value.name
  changed_files       = each.value.changed_files
  module_file_path    = each.value.module_file_path
  variables_file_path = each.value.variables_file_path
}
