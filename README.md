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

- we use docker to create a versioned artifact that contain the code for
  terraform providers, local modules, and main configuration.

### Local Providers Mirror

- By mirroring the providers locally, we ensure that Terraform runs do not
  depend on external network availability at runtime.
- the exact versions of providers ensures reproducibility across runs
- we can accomplish this by running `terraform init` at build time
- NOTE: Since we are using -backend=false during build time, we must therefore
  initialize the backend at runtime.

### Building the image

Build the image

```bash
docker build . -t my-terraform-image
```

Create a volume to share data between container runs

```bash
docker volume create tf-data
```

Init

- TODO: we need to initialize the remote backend at run time

```bash
docker run --rm \
  -v tf-data:/tf \
  my-terraform-image \
  terraform -chdir=/tf init
```

Plan

- mount the input.yaml file from host machine
- TODO: we need to auth with aws

```bash
docker run --rm \
  -v tf-data:/tf \
  -v "$(pwd)/input.yaml:/tf/input.yaml" \
  my-terraform-image \
  terraform -chdir=/tf plan
```
