variable "environments" {
  description = "Map of environments."
  type = object({
    devopssandbox = object({
      git_ref    = string
      org_id     = string
      project_id = string
      workflows = list(object({
        name                = string
        changed_files       = string
        module_file_path    = string
        variables_file_path = string
      }))
    })

    development = object({
      git_ref    = string
      org_id     = string
      project_id = string
      workflows = list(object({
        name                = string
        changed_files       = string
        module_file_path    = string
        variables_file_path = string
      }))
    })


    staging = object({
      git_ref    = string
      org_id     = string
      project_id = string
      workflows = list(object({
        name                = string
        changed_files       = string
        module_file_path    = string
        variables_file_path = string
      }))
    })
  })
}
