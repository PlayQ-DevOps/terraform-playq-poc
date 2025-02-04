# Organization
resource "harness_platform_organization" "organization" {
  identifier = var.organization.identifier
  name       = var.organization.name
}

# Projects
resource "harness_platform_project" "project" {
  for_each = {
    devopssandbox = var.organization.projects.devopssandbox
    development   = var.organization.projects.development
    staging       = var.organization.projects.staging
    # production    = var.organization.projects.production
  }

  color      = each.value.color
  identifier = each.value.identifier
  name       = each.value.name
  org_id     = harness_platform_organization.organization.id
}

# Workflows (Workspace, Pipeline, and Trigger)
module "dosb_workflow" {
  for_each = { for workflow in var.organization.projects.devopssandbox.workflows : workflow.name => workflow }

  source = "./modules/harness_main_workflow"

  git_ref          = var.organization.projects.devopssandbox.git_ref
  org_id           = harness_platform_organization.organization.id
  project_id       = harness_platform_project.project["devopssandbox"].id
  name             = each.value.name
  changed_files    = each.value.changed_files
  module_file_path = each.value.module_file_path
  variables_file_paths = concat(
    each.value.variables_file_paths,
    var.organization.projects["devopssandbox"].variables_file_paths,
    var.organization.variables_file_paths,
  )
}

module "dev_workflow" {
  for_each = { for workflow in var.organization.projects.development.workflows : workflow.name => workflow }

  source = "./modules/harness_release_workflow"

  git_ref          = var.organization.projects.development.git_ref
  org_id           = harness_platform_organization.organization.id
  project_id       = harness_platform_project.project["development"].id
  name             = each.value.name
  changed_files    = each.value.changed_files
  module_file_path = each.value.module_file_path
  variables_file_paths = concat(
    each.value.variables_file_paths,
    var.organization.projects["development"].variables_file_paths,
    var.organization.variables_file_paths,
  )
}


module "stg_workflow" {
  for_each = { for workflow in var.organization.projects.staging.workflows : workflow.name => workflow }

  source = "./modules/harness_release_workflow"

  git_ref          = var.organization.projects.staging.git_ref
  org_id           = harness_platform_organization.organization.id
  project_id       = harness_platform_project.project["staging"].id
  name             = each.value.name
  changed_files    = each.value.changed_files
  module_file_path = each.value.module_file_path
  variables_file_paths = concat(
    each.value.variables_file_paths,
    var.organization.projects["staging"].variables_file_paths,
    var.organization.variables_file_paths,
  )
}
