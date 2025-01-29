environments = {
  devopssandbox = {
    git_ref    = "main"
    org_id     = ""
    project_id = ""
    workflows = [
      # standard workflow object - same accross environments?
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
    org_id     = ""
    project_id = ""
    workflows = [

    ]


  }
  staging = {
    git_ref    = "<+pipeline.variables.GIT_TAG>"
    org_id     = ""
    project_id = ""
    workflows = [

    ]

  }

}


