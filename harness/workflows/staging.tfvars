# Staging Workflows

release_workflows = [
  {
    workspace_name      = "stg_service_a"
    changed_files_regex = "stg-regex-a"
  },
  {
    workspace_name      = "stg_service_b"
    changed_files_regex = "stg-regex-b"
  },
  {
    workspace_name      = "stg_service_c"
    changed_files_regex = "stg-regex-c"
  }
]

