# Organization: Platform Infrastructure

# Project: DevOps Sandbox

# Project: Development

# Project: Staging

# Project: Production

# Workflow(Workspace, Pipeline, and Trigger): DevOps Sandbox
# for each item in workflows/dosb use main_workflow module
# Workflow: dosb_service-a
# Workflow: dosb_service-b
# Workflow: dosb_service-c
module "main_workflow" {
  for_each = { for w in var.main_workflows : w.workspace_name => w }

  source = "./modules/harness_main_workflow"

  workspace_name = each.value.workspace_name
}

# Workflow(Workspace, Pipeline, and Trigger): Development
# for each item in workflows/dev use release_workflow module
# Workflow: dev_service-a
# Workflow: dev_service-b
# Workflow: dev_service-c

# Workflow(Workspace, Pipeline, and Trigger): Staging
# for each item in workflows/stg use release_workflow module
# Workflow: stg_service-a
# Workflow: stg_service-b
# Workflow: stg_service-c

# Workflow(Workspace, Pipeline, and Trigger): Production
# for each item in workflows/prd use release_workflow module
# Workflow: prd_service-a
# Workflow: prd_service-b
# Workflow: prd_service-c
module "release_workflow" {
  for_each = { for w in var.release_workflows : w.workspace_name => w }

  source = "./modules/harness_release_workflow"

  workspace_name      = each.value.workspace_name
  changed_files_regex = each.value.changed_files_regex
}
