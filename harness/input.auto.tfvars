environments = {
  devopssandbox = {
    git_ref    = "main"
    identifier = "dosb"
    name       = "DevOps Sandbox"
    workflows = [
      {
        name                = "poc_dosb_service_a"
        changed_files       = "environments/devopssandbox/service-a/.*,terraform/service-a/.*"
        module_file_path    = "./terraform/service-a"
        variables_file_path = "./environments/devopssandbox/service-a/input.tfvars"
      },
      {
        name                = "poc_dosb_service_b"
        changed_files       = "environments/devopssandbox/service-b/.*,terraform/service-b/.*"
        module_file_path    = "./terraform/service-b"
        variables_file_path = "./environments/devopssandbox/service-b/input.tfvars"
      }
    ]
  }

  development = {
    git_ref    = "<+pipeline.variables.GIT_TAG>"
    identifier = "dev"
    name       = "Development"

    workflows = [
      {
        name                = "poc_dev_service_a"
        changed_files       = "environments/development/service-a/.*,terraform/service-a/.*"
        module_file_path    = "./terraform/service-a"
        variables_file_path = "./environments/development/service-a/input.tfvars"
      },
      {
        name                = "poc_dev_service_b"
        changed_files       = "environments/development/service-b/.*,terraform/service-b/.*"
        module_file_path    = "./terraform/service-b"
        variables_file_path = "./environments/development/service-b/input.tfvars"
      }
    ]
  }

  staging = {
    git_ref    = "<+pipeline.variables.GIT_TAG>"
    identifier = "stg"
    name       = "Staging"

    workflows = [
      {
        name                = "poc_stg_service_a"
        changed_files       = "environments/staging/service-a/.*,terraform/service-a/.*"
        module_file_path    = "./terraform/service-a"
        variables_file_path = "./environments/staging/service-a/input.tfvars"
      },
      {
        name                = "poc_stg_service_b"
        changed_files       = "environments/staging/service-b/.*,terraform/service-b/.*"
        module_file_path    = "./terraform/service-b"
        variables_file_path = "./environments/staging/service-b/input.tfvars"
      }
    ]
  }
}
