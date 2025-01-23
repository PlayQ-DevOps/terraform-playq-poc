#

variable "main_workflows" {
  type = list(object({
    workspace_name = string
  }))
  description = "List of workflow objects for main branch workflows."
  default     = []
}

variable "release_workflows" {
  type = list(object({
    workspace_name      = string
    changed_files_regex = string
  }))
  description = "List of workflow objects for release workflows."
  default     = []
}
