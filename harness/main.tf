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

  changed_files = each.value.changed_files
  environment_variables = merge(
    # last entry takes precedence
    var.organization.environment_variables,
    var.organization.projects["devopssandbox"].environment_variables,
    each.value.environment_variables
  )
  identifier = each.value.identifier
  inputs_file_paths = distinct(concat(
    var.organization.inputs_file_paths,
    var.organization.projects["devopssandbox"].inputs_file_paths,
    each.value.inputs_file_paths,
  ))
  git_ref          = var.organization.projects.devopssandbox.git_ref
  module_file_path = each.value.module_file_path
  name             = each.value.name
  org_id           = harness_platform_organization.organization.id
  project_id       = harness_platform_project.project["devopssandbox"].id
}

module "dev_workflow" {
  for_each = { for workflow in var.organization.projects.development.workflows : workflow.name => workflow }

  source = "./modules/harness_release_workflow"

  changed_files = each.value.changed_files
  environment_variables = merge(
    # last entry takes precedence
    var.organization.environment_variables,
    var.organization.projects["development"].environment_variables,
    each.value.environment_variables
  )
  identifier = each.value.identifier
  inputs_file_paths = distinct(concat(
    var.organization.inputs_file_paths,
    var.organization.projects["development"].inputs_file_paths,
    each.value.inputs_file_paths,
  ))
  git_ref          = var.organization.projects.development.git_ref
  module_file_path = each.value.module_file_path
  name             = each.value.name
  org_id           = harness_platform_organization.organization.id
  project_id       = harness_platform_project.project["development"].id
}


module "stg_workflow" {
  for_each = { for workflow in var.organization.projects.staging.workflows : workflow.name => workflow }

  source = "./modules/harness_release_workflow"

  changed_files = each.value.changed_files
  environment_variables = merge(
    # last entry takes precedence
    var.organization.environment_variables,
    var.organization.projects["staging"].environment_variables,
    each.value.environment_variables
  )
  identifier = each.value.identifier
  inputs_file_paths = distinct(concat(
    var.organization.inputs_file_paths,
    var.organization.projects["staging"].inputs_file_paths,
    each.value.inputs_file_paths,
  ))
  git_ref          = var.organization.projects.staging.git_ref
  module_file_path = each.value.module_file_path
  name             = each.value.name
  org_id           = harness_platform_organization.organization.id
  project_id       = harness_platform_project.project["staging"].id
}
