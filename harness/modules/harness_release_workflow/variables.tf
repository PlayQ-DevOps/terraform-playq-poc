variable "name" {
  type        = string
  description = "The name of the workflow."
}

variable "changed_files_regex" {
  type        = string
  description = "The regex expression of the file paths to watch."
}

