variable "organization" {
  description = "PlayQ Harness Organization Object Schema."

  type = object({
    identifier          = string
    name                = string
    variables_file_path = string

    projects = map(object({
      color               = string
      git_ref             = string
      identifier          = string
      name                = string
      variables_file_path = string

      workflows = list(object({
        name                = string
        changed_files       = string
        module_file_path    = string
        variables_file_path = string
      }))
    }))
  })
}

