organization = {
  identifier           = "POC"
  name                 = "POC"
  variables_file_paths = []
  secrets_file_paths   = []

  projects = {

    devopssandbox = {
      color                = "#E8E9EB"
      git_ref              = "main"
      identifier           = "dosb"
      name                 = "DevOps Sandbox"
      variables_file_paths = []
      secrets_file_paths   = []


      workflows = [
        {
          name                 = "poc_dosb_service_a"
          changed_files        = "environments/devopssandbox/service-a/.*,terraform/service-a/.*"
          module_file_path     = "./terraform/service-a"
          variables_file_paths = ["./environments/devopssandbox/service-a/input.tfvars"]
          secrets_file_paths   = []

        },
        {
          name                 = "poc_dosb_service_b"
          changed_files        = "environments/devopssandbox/service-b/.*,terraform/service-b/.*"
          module_file_path     = "./terraform/service-b"
          variables_file_paths = ["./environments/devopssandbox/service-b/input.tfvars"]
          secrets_file_paths   = []

        },
        {
          name                 = "poc_dosb_service_c"
          changed_files        = "environments/devopssandbox/service-c/.*,terraform/service-c/.*"
          module_file_path     = "./terraform/service-c"
          variables_file_paths = ["./environments/devopssandbox/service-c/input.tfvars"]
          secrets_file_paths   = []

        }
      ]
    }

    development = {
      color                = "#34D399"
      git_ref              = "<+pipeline.variables.GIT_TAG>"
      identifier           = "dev"
      name                 = "Development"
      variables_file_paths = []
      secrets_file_paths   = []


      workflows = [
        {
          name                 = "poc_dev_service_a"
          changed_files        = "environments/development/service-a/.*,terraform/service-a/.*"
          module_file_path     = "./terraform/service-a"
          variables_file_paths = ["./environments/development/service-a/input.tfvars"]
          secrets_file_paths   = []

        },
        {
          name                 = "poc_dev_service_b"
          changed_files        = "environments/development/service-b/.*,terraform/service-b/.*"
          module_file_path     = "./terraform/service-b"
          variables_file_paths = ["./environments/development/service-b/input.tfvars"]
          secrets_file_paths   = []

        },
        {
          name                 = "poc_dev_service_c"
          changed_files        = "environments/development/service-c/.*,terraform/service-c/.*"
          module_file_path     = "./terraform/service-c"
          variables_file_paths = ["./environments/development/service-c/input.tfvars"]
          secrets_file_paths   = []

        }
      ]
    }

    staging = {
      color                = "#FACC15"
      git_ref              = "<+pipeline.variables.GIT_TAG>"
      identifier           = "stg"
      name                 = "Staging"
      variables_file_paths = []
      secrets_file_paths   = []


      workflows = [
        {
          name                 = "poc_stg_service_a"
          changed_files        = "environments/staging/service-a/.*,terraform/service-a/.*"
          module_file_path     = "./terraform/service-a"
          variables_file_paths = ["./environments/staging/service-a/input.tfvars"]
          secrets_file_paths   = []

        },
        {
          name                 = "poc_stg_service_b"
          changed_files        = "environments/staging/service-b/.*,terraform/service-b/.*"
          module_file_path     = "./terraform/service-b"
          variables_file_paths = ["./environments/staging/service-b/input.tfvars"]
          secrets_file_paths   = []

        },
        {
          name                 = "poc_stg_service_c"
          changed_files        = "environments/staging/service-c/.*,terraform/service-c/.*"
          module_file_path     = "./terraform/service-c"
          variables_file_paths = ["./environments/staging/service-c/input.tfvars"]
          secrets_file_paths   = []

        }
      ]
    }

    #production = {
    #  color               = "#EF4444"
    #  git_ref             = "<+pipeline.variables.GIT_TAG>"
    #  identifier          = "prd"
    #  name                = "Production"
    #  variables_file_paths = []
    #  secrets_file_paths = []


    #  workflows = [
    #    {
    #      name                = "poc_prd_service_a"
    #      changed_files       = "environments/production/service-a/.*,terraform/service-a/.*"
    #      module_file_path    = "./terraform/service-a"
    #      variables_file_paths = ["./environments/production/service-a/input.tfvars"]
    #      secrets_file_paths = []

    #    },
    #    {
    #      name                = "poc_prd_service_b"
    #      changed_files       = "environments/production/service-b/.*,terraform/service-b/.*"
    #      module_file_path    = "./terraform/service-b"
    #      variables_file_paths = ["./environments/production/service-b/input.tfvars"]
    #      secrets_file_paths = []
    #    }
    #  ]
    #}
  }
}
