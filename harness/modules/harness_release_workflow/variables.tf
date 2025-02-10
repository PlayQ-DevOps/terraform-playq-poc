variable "environment_variables" {
  type        = map(string)
  description = "The map of environment variables."
}

variable "git_ref" {
  type        = string
  description = "The branch or tag to reference from the git repository."
}

variable "identifier" {
  type        = string
  description = "The identifier to used identify the Workspace, Pipeline and Trigger"
}

variable "inputs_file_paths" {
  type        = list(string)
  description = "The list of relative file paths from root to the tfvars files."
}

variable "module_file_path" {
  type        = string
  description = "The relative file path from root to the module source code."
}

variable "name" {
  type        = string
  description = "The name of the workflow."
}

variable "org_id" {
  type        = string
  description = "The harness organization identifier."
}

variable "project_id" {
  type        = string
  description = "The harness project identifier."
}

variable "trigger_file_paths" {
  type        = string
  description = "The comma separated list of files to trigger on."
}
