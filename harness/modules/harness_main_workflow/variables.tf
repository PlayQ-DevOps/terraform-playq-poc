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
variable "module_file_path" {
  type        = string
  description = "The relative file path from root to the module source code."
}
variable "variables_file_path" {
  type        = string
  description = "The relative file path from root to the tfvars file."
}
variable "changed_files" {
  type        = string
  description = "The comma separated list of files to trigger on."
}
