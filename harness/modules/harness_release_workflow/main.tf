resource "harness_platform_workspace" "workspace" {
  name                    = var.name
  identifier              = var.name
  org_id                  = var.org_id
  project_id              = var.project_id
  provisioner_type        = "terraform"
  provisioner_version     = "1.5.6"
  repository              = "terraform-playq-poc"
  repository_path         = var.module_file_path
  repository_commit       = var.git_ref
  cost_estimation_enabled = false
  provider_connector      = ""
  repository_connector    = "account.PlayQDevOps"

  terraform_variable_file {
    repository           = "terraform-playq-poc"
    repository_path      = var.variables_file_path
    repository_connector = "account.PlayQDevOps"
    repository_commit    = var.git_ref
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
        templateRef: account.platform_infra_release
        versionLabel: v0.0.1
        templateInputs:
          stages:
            - stage:
                identifier: main
                type: IACM
                spec:
                  workspace: ${var.name}
          variables:
            - name: GIT_TAG
              type: String
              value: <+input>
            - name: CHANGED_FILES
              type: String
              value: ${var.changed_files} 
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
            type: Release
            spec:
              connectorRef: account.PlayQDevOps
              autoAbortPreviousExecutions: false
              payloadConditions: []
              headerConditions: []
              repoName: terraform-playq-poc
              actions:
                - Publish
      inputYaml: |
        pipeline:
          identifier: ${var.name}
          template:
            templateInputs:
              variables:
                - name: GIT_TAG
                  type: String
                  value: <+trigger.payload.release.tag_name>
          EOT
}
