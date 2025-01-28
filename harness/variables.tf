variable "environments" {
  description = "Map of environments."
  type = object({
    devopssandbox = object({
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
