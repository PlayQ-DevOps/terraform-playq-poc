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
locals {
  environments = [
    "devopssandbox",
    "development",
    "staging",
    "production"
  ]

  environments_source_map = {
    devopssandbox = "./modules/harness_main_workflow"
    development   = "./modules/harness_release_workflow"
    staging       = "./modules/harness_release_workflow"
    production    = "./modules/harness_release_workflow"
  }

  workflows = flatten([
    for environment in local.environments : [
      for workflow in var.organization.projects[environment].workflows : {
        changed_files = workflow.changed_files
        environment   = environment
        environment_variables = merge(
          # last entry takes precedence
          var.organization.environment_variables,
          var.organization.projects[environment].environment_variables,
          workflow.environment_variables
        )
        identifier       = workflow.identifier
        module_file_path = workflow.module_file_path
        name             = workflow.name
        variables_file_paths = concat(
          wf.variables_file_paths,
          var.organization.projects[env].variables_file_paths,
          var.organization.variables_file_paths
        )
      }
    ]
  ])
}

module "workflows" {
  for_each = {
    for workflow in local.workflows : "${workflow.environment}-${workflow.identifier}" => workflow
  }

  source = local.environment_source_map[each.value.environment]

  changed_files         = each.value.changed_files
  environment_variables = each.value.environment_variables
  git_ref               = var.organization.projects[each.value.environment].git_ref
  module_file_path      = each.value.module_file_path
  name                  = each.value.name
  org_id                = harness_platform_organization.organization.id
  project_id            = harness_platform_project.project[each.value.environment].id
  variables_file_paths  = each.value.variables_file_paths
}

# module "dosb_workflow" {
#   for_each = { for workflow in var.organization.projects.devopssandbox.workflows : workflow.name => workflow }
# 
#   source = "./modules/harness_main_workflow"
# 
#   changed_files = each.value.changed_files
#   environment_variables = merge(
#     # last entry takes precedence
#     var.organization.environment_variables,
#     var.organization.projects["devopssandbox"].environment_variables,
#     each.value.environment_variables
#   )
#   git_ref          = var.organization.projects.devopssandbox.git_ref
#   module_file_path = each.value.module_file_path
#   name             = each.value.name
#   org_id           = harness_platform_organization.organization.id
#   project_id       = harness_platform_project.project["devopssandbox"].id
#   variables_file_paths = distinct(concat(
#     var.organization.variables_file_paths,
#     var.organization.projects["devopssandbox"].variables_file_paths,
#     each.value.variables_file_paths,
#   ))
# }
# 
# module "dev_workflow" {
#   for_each = { for workflow in var.organization.projects.development.workflows : workflow.name => workflow }
# 
#   source = "./modules/harness_release_workflow"
# 
#   changed_files = each.value.changed_files
#   environment_variables = merge(
#     # last entry takes precedence
#     var.organization.environment_variables,
#     var.organization.projects["development"].environment_variables,
#     each.value.environment_variables
#   )
#   git_ref          = var.organization.projects.development.git_ref
#   module_file_path = each.value.module_file_path
#   name             = each.value.name
#   org_id           = harness_platform_organization.organization.id
#   project_id       = harness_platform_project.project["development"].id
#   variables_file_paths = distinct(concat(
#     var.organization.variables_file_paths,
#     var.organization.projects["development"].variables_file_paths,
#     each.value.variables_file_paths,
#   ))
# }
# 
# 
# module "stg_workflow" {
#   for_each = { for workflow in var.organization.projects.staging.workflows : workflow.name => workflow }
# 
#   source = "./modules/harness_release_workflow"
# 
#   changed_files = each.value.changed_files
#   environment_variables = merge(
#     # last entry takes precedence
#     var.organization.environment_variables,
#     var.organization.projects["staging"].environment_variables,
#     each.value.environment_variables
#   )
#   git_ref          = var.organization.projects.staging.git_ref
#   module_file_path = each.value.module_file_path
#   name             = each.value.name
#   org_id           = harness_platform_organization.organization.id
#   project_id       = harness_platform_project.project["staging"].id
#   variables_file_paths = distinct(concat(
#     var.organization.variables_file_paths,
#     var.organization.projects["staging"].variables_file_paths,
#     each.value.variables_file_paths,
#   ))
# }
