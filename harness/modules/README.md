# Overview

The main differneces between the two workflow module are as follows:

| Resource  | Main Workflow                                                                                                                     | Release Workflow                                                                                                                                           |
| --------- | --------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Workspace | uses `repository_branch` for both the Workspace configuration and the terraform variable file.<br><br>This value is always `main` | uses `repository_commit` for both the Workspace configuration and the terraform variable file.<br><br>This value is always `<+pipeline.variables.GIT_TAG>` |
| Pipeline  | No pipeline variables.<br><br>Uses the `account.platform_infra_main` pipeline template.                                           | GIT_TAG and CHANGED_FILES are defined as pipeline variables.<br><br>Uses the `account.platform_infra_release` pipeline template.                           |
| Trigger   | N/A                                                                                                                               | Provides the runtime value for GIT_TAG as <+trigger.payload.release.tag_name>                                                                              |
