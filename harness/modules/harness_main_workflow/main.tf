resource "harness_platform_workspace" "workspace" {
  identifier              = var.name
  name                    = var.name
  org_id                  = var.org_id
  project_id              = var.project_id
  provisioner_type        = "terraform"
  provisioner_version     = "1.5.6"
  repository              = "terraform-playq-poc"
  repository_path         = var.module_file_path
  repository_branch       = var.git_ref
  cost_estimation_enabled = false
  provider_connector      = ""
  repository_connector    = "account.PlayQDevOps"

  dynamic "environment_variable" {
    for_each = var.environment_variables

    content {
      key        = environment_variable.key
      value      = environment_variable.value
      value_type = "string"
    }
  }

  dynamic "terraform_variable_file" {
    for_each = var.variables_file_paths

    content {
      repository           = "terraform-playq-poc"
      repository_path      = terraform_variable_file.value
      repository_connector = "account.PlayQDevOps"
      repository_branch    = var.git_ref
    }
  }
}

resource "harness_platform_pipeline" "pipeline" {
  identifier = var.name
  name       = var.name
  org_id     = var.org_id
  project_id = var.project_id
  yaml       = <<-EOT
    pipeline:
        name: ${var.name}
        identifier: ${var.name}
        template:
            templateRef: account.platform_infra_main
            versionLabel: v0.0.1
            templateInputs:
                stages:
                    - stage:
                        identifier: main
                        type: IACM
                        spec:
                            workspace: ${var.name}
        projectIdentifier: ${var.project_id}
        orgIdentifier: ${var.org_id}
  EOT
}

resource "harness_platform_triggers" "trigger" {
  identifier = var.name
  name       = var.name
  org_id     = var.org_id
  project_id = var.project_id
  target_id  = harness_platform_pipeline.pipeline.id
  yaml       = <<-EOT
    trigger:
      name: ${var.name}
      identifier: ${var.name}
      enabled: true
      encryptedWebhookSecretIdentifier: ""
      description: ""
      orgIdentifier: ${var.org_id}
      stagesToExecute: []
      projectIdentifier: ${var.project_id}
      pipelineIdentifier: ${var.name}
      source:
        type: Webhook
        spec:
          type: Github
          spec:
            type: Push
            spec:
              connectorRef: account.PlayQDevOps
              autoAbortPreviousExecutions: false
              payloadConditions:
                - key: changedFiles
                  operator: In
                  value: ${var.changed_files}
                - key: targetBranch
                  operator: Equals
                  value: ${var.git_ref}
              headerConditions: []
              repoName: terraform-playq-poc
              actions: []
          EOT
}
