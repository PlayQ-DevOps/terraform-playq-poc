organization = {
  environment_variables = {
    TEST = "TEST"
  }
  identifier           = "POC"
  name                 = "POC"
  secrets_file_paths   = []
  variables_file_paths = []

  projects = {

    devopssandbox = {
      color                 = "#E8E9EB"
      environment_variables = {}
      git_ref               = "main"
      identifier            = "dosb"
      name                  = "DevOps Sandbox"
      secrets_file_paths    = []
      variables_file_paths  = []

      workflows = [
        {
          changed_files         = "environments/devopssandbox/service-a/.*,terraform/service-a/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-a"
          name                  = "poc_dosb_service_a"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/devopssandbox/service-a/input.tfvars"]
        },
        {
          changed_files         = "environments/devopssandbox/service-b/.*,terraform/service-b/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-b"
          name                  = "poc_dosb_service_b"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/devopssandbox/service-b/input.tfvars"]
        },
        {
          changed_files = "environments/devopssandbox/service-c/.*,terraform/service-c/.*"
          environment_variables = {
            "TEST_DOSB_SERVICE_C" = "TEST_DOSB_SERVICE_C"
          }
          module_file_path     = "./terraform/service-c"
          name                 = "poc_dosb_service_c"
          secrets_file_paths   = []
          variables_file_paths = ["./environments/devopssandbox/service-c/input.tfvars"]
        }
      ]
    }

    development = {
      color                 = "#34D399"
      environment_variables = {}
      git_ref               = "<+pipeline.variables.GIT_TAG>"
      identifier            = "dev"
      name                  = "Development"
      secrets_file_paths    = []
      variables_file_paths  = []

      workflows = [
        {
          changed_files         = "environments/development/service-a/.*,terraform/service-a/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-a"
          name                  = "poc_dev_service_a"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/development/service-a/input.tfvars"]
        },
        {
          changed_files         = "environments/development/service-b/.*,terraform/service-b/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-b"
          name                  = "poc_dev_service_b"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/development/service-b/input.tfvars"]
        },
        {
          changed_files         = "environments/development/service-c/.*,terraform/service-c/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-c"
          name                  = "poc_dev_service_c"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/development/service-c/input.tfvars"]
        }
      ]
    }

    staging = {
      color                 = "#FACC15"
      environment_variables = {}
      git_ref               = "<+pipeline.variables.GIT_TAG>"
      identifier            = "stg"
      name                  = "Staging"
      secrets_file_paths    = []
      variables_file_paths  = []

      workflows = [
        {
          changed_files         = "environments/staging/service-a/.*,terraform/service-a/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-a"
          name                  = "poc_stg_service_a"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/staging/service-a/input.tfvars"]
        },
        {
          changed_files         = "environments/staging/service-b/.*,terraform/service-b/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-b"
          name                  = "poc_stg_service_b"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/staging/service-b/input.tfvars"]
        },
        {
          changed_files         = "environments/staging/service-c/.*,terraform/service-c/.*"
          environment_variables = {}
          module_file_path      = "./terraform/service-c"
          name                  = "poc_stg_service_c"
          secrets_file_paths    = []
          variables_file_paths  = ["./environments/staging/service-c/input.tfvars"]
        }
      ]
    }
  }
}
