variable "organization" {
  description = "PlayQ Harness Organization Schema."

  type = object({
    environment_variables = map(string)
    identifier            = string
    name                  = string
    secrets_file_paths    = list(string)
    variables_file_paths  = list(string)

    projects = map(object({
      color                 = string
      environment_variables = map(string)
      git_ref               = string
      identifier            = string
      name                  = string
      secrets_file_paths    = list(string)
      variables_file_paths  = list(string)

      workflows = list(object({
        changed_files         = string
        environment_variables = map(string)
        identifier            = string
        module_file_path      = string
        name                  = string
        secrets_file_paths    = list(string)
        variables_file_paths  = list(string)
      }))
    }))
  })
}

