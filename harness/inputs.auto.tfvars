organization = {
  environment_variables = {
    TEST = "TEST"
  }
  environment_secrets = {}
  identifier          = "POC"
  inputs_file_paths   = ["./environments/inputs.tfvars"]
  name                = "POC"
  secrets_file_paths  = ["./environments/secrets.tfvars"]

  projects = {

    devopssandbox = {
      color                 = "#E8E9EB"
      environment_variables = {}
      environment_secrets   = {}
      git_ref               = "main"
      identifier            = "dosb"
      inputs_file_paths     = ["./environments/devopssandbox/inputs.tfvars"]
      name                  = "DevOps Sandbox"
      secrets_file_paths    = ["./environments/devopssandbox/secrets.tfvars"]

      workflows = [
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_dosb_service_a"
          inputs_file_paths     = ["./environments/devopssandbox/service-a/inputs.tfvars"]
          module_file_path      = "./terraform/service-a"
          name                  = "poc_dosb_service_a"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/devopssandbox/inputs.tfvars",
            "environments/devopssandbox/secrets.tfvars",
            "environments/devopssandbox/service-a/.*",
            "terraform/service-a/.*"
          ]
        },
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_dosb_service_b"
          inputs_file_paths     = ["./environments/devopssandbox/service-b/inputs.tfvars"]
          module_file_path      = "./terraform/service-b"
          name                  = "poc_dosb_service_b"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/devopssandbox/inputs.tfvars",
            "environments/devopssandbox/secrets.tfvars",
            "environments/devopssandbox/service-b/.*",
            "terraform/service-b/.*"
          ]
        },
        {
          environment_variables = {
            "TEST_DOSB_SERVICE_C" = "TEST_DOSB_SERVICE_C"
          }
          environment_secrets = {}
          identifier          = "poc_dosb_service_c"
          inputs_file_paths   = ["./environments/devopssandbox/service-c/inputs.tfvars"]
          module_file_path    = "./terraform/service-c"
          name                = "poc_dosb_service_c"
          secrets_file_paths  = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/devopssandbox/inputs.tfvars",
            "environments/devopssandbox/secrets.tfvars",
            "environments/devopssandbox/service-c/.*",
            "terraform/service-c/.*"
          ]
        }
      ]
    }

    development = {
      color                 = "#34D399"
      environment_variables = {}
      environment_secrets   = {}
      git_ref               = "<+pipeline.variables.GIT_TAG>"
      identifier            = "dev"
      inputs_file_paths     = ["./environments/development/inputs.tfvars"]
      name                  = "Development"
      secrets_file_paths    = ["./environments/development/secrets.tfvars"]

      workflows = [
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_dev_service_a"
          inputs_file_paths     = ["./environments/development/service-a/inputs.tfvars"]
          module_file_path      = "./terraform/service-a"
          name                  = "poc_dev_service_a"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/development/inputs.tfvars",
            "environments/development/secrets.tfvars",
            "environments/development/service-a/.*",
            "terraform/service-a/.*"
          ]
        },
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_dev_service_b"
          inputs_file_paths     = ["./environments/development/service-b/inputs.tfvars"]
          module_file_path      = "./terraform/service-b"
          name                  = "poc_dev_service_b"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/development/inputs.tfvars",
            "environments/development/secrets.tfvars",
            "environments/development/service-b/.*",
            "terraform/service-b/.*"
          ]
        },
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_dev_service_c"
          inputs_file_paths     = ["./environments/development/service-c/inputs.tfvars"]
          module_file_path      = "./terraform/service-c"
          name                  = "poc_dev_service_c"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/development/inputs.tfvars",
            "environments/development/secrets.tfvars",
            "environments/development/service-c/.*",
            "terraform/service-c/.*"
          ]
        }
      ]
    }

    staging = {
      color                 = "#FACC15"
      environment_variables = {}
      environment_secrets   = {}
      git_ref               = "<+pipeline.variables.GIT_TAG>"
      identifier            = "stg"
      inputs_file_paths     = ["./environments/staging/inputs.tfvars"]
      name                  = "Staging"
      secrets_file_paths    = ["./environments/staging/secrets.tfvars"]

      workflows = [
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_stg_service_a"
          inputs_file_paths     = ["./environments/staging/service-a/inputs.tfvars"]
          module_file_path      = "./terraform/service-a"
          name                  = "poc_stg_service_a"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/staging/inputs.tfvars",
            "environments/staging/secrets.tfvars",
            "environments/staging/service-a/.*",
            "terraform/service-a/.*"
          ]
        },
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_stg_service_b"
          inputs_file_paths     = ["./environments/staging/service-b/inputs.tfvars"]
          module_file_path      = "./terraform/service-b"
          name                  = "poc_stg_service_b"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/staging/inputs.tfvars",
            "environments/staging/secrets.tfvars",
            "environments/staging/service-b/.*",
            "terraform/service-b/.*"
          ]
        },
        {
          environment_variables = {}
          environment_secrets   = {}
          identifier            = "poc_stg_service_c"
          inputs_file_paths     = ["./environments/staging/service-c/inputs.tfvars"]
          module_file_path      = "./terraform/service-c"
          name                  = "poc_stg_service_c"
          secrets_file_paths    = []
          trigger_file_paths = [
            "environments/inputs.tfvars",
            "environments/secrets.tfvars",
            "environments/staging/inputs.tfvars",
            "environments/staging/secrets.tfvars",
            "environments/staging/service-c/.*",
            "terraform/service-c/.*"
          ]
        }
      ]
    }
  }
}
