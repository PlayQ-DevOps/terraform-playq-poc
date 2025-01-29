# Main Branch Workflow

# Workspace
resource "harness_platform_workspace" "example" {
  name                    = var.name                                              # from environments key
  identifier              = var.name                                              # from environments key
  org_id                  = var.org_id                                            # from environments key
  project_id              = var.project_id                                        # from environments key
  provisioner_type        = "terraform"                                           # hard code
  provisioner_version     = "1.5.6"                                               # hard code
  repository              = "https://github.com/PlayQ-DevOps/terraform-playq-poc" # hard code
  repository_path         = var.module_file_path                                  # from workflow object
  repository_branch       = var.git_ref
  cost_estimation_enabled = false
  provider_connector      = "" # hard code
  repository_connector    = "" # hard code

  terraform_variable_file {
    repository           = "https://github.com/PlayQ-DevOps/terraform-playq-poc" # hard code
    repository_path      = var.variables_file_path                               # from workflow obj 
    repository_connector = ""
    repository_branch    = var.git_ref
  }
}

# Pipeline
#resource "harness_platform_pipeline" "example" {
#  identifier = "identifier"
#  org_id     = "orgIdentifier"
#  project_id = "projectIdentifier"
#  name       = "name"
#  git_details {
#    branch_name    = "branchName"
#    commit_message = "commitMessage"
#    file_path      = "filePath"
#    connector_ref  = "connectorRef"
#    store_type     = "REMOTE"
#    repo_name      = "repoName"
#  }
#  tags = {}
#  yaml = <<-EOT
#    pipeline:
#        name: ${var.name}
#        identifier: ${var.name}
#        tags: {}
#        template:
#            templateRef: account.platform_infra_main
#            versionLabel: v0.0.1
#            templateInputs:
#                stages:
#                    - stage:
#                        identifier: main
#                        type: IACM
#                        spec:
#                            workspace: ${var.name}
#        projectIdentifier: ${var.project_id}
#        orgIdentifier: ${var.org_id}
#  EOT
#}
#
## Trigger
#resource "harness_platform_triggers" "example" {
#  identifier = var.name
#  org_id     = var.org_id
#  project_id = var.project_id
#  name       = var.name
#  target_id  = var.name
#  yaml       = <<-EOT
#trigger:
#  name: ${var.name}
#  identifier: ${var.name}
#  enabled: true
#  encryptedWebhookSecretIdentifier: ""
#  description: ""
#  tags: {}
#  orgIdentifier: ${var.org_id}
#  stagesToExecute: []
#  projectIdentifier: ${var.project_id}
#  pipelineIdentifier: ${var.name}
#  source:
#    type: Webhook
#    spec:
#      type: Github
#      spec:
#        type: Push
#        spec:
#          connectorRef: playqpoc
#          autoAbortPreviousExecutions: false
#          payloadConditions:
#            - key: changedFiles
#              operator: In
#              value: ${var.changed_files}
#            - key: targetBranch
#              operator: Equals
#              value: main
#          headerConditions: []
#          repoName: terraform-playq-poc
#          actions: []
#      EOT
#}
#
