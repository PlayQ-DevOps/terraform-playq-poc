variable "environments" {
  description = "Map of all environments by name."
  type = map(object({
    git_ref    = string
    identifier = string
    name       = string
    workflows = list(object({
      name                = string
      changed_files       = string
      module_file_path    = string
      variables_file_path = string
    }))
  }))
}

