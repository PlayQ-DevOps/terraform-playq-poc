## Separate Configuration from the Code

- the config of the terraform is completely separate from the teraform code
  creating a clean yet strongly typed interface for the infrastructure
  module/service
- this catched more errors at Plan time
- this reduces confusion about the source of input variables (eliminating
  harness-bootstrap) and makes reviewing the code much easier
- the config is located in a single place and is consumed by the code in a
  single place
- this sets us up to create an immutable artifact to be easily promoted across
  environments

## Create a Terraform Artifact
