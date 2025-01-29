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
  repository_commit       = var.git_ref
  cost_estimation_enabled = false
  provider_connector      = "" # hard code
  repository_connector    = "" # hard code

  terraform_variable_file {
    repository           = "https://github.com/PlayQ-DevOps/terraform-playq-poc" # hard code
    repository_path      = var.variables_file_path                               # from workflow obj 
    repository_connector = ""
    repository_commit    = var.git_ref
  }
}
