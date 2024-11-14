# STAGE 1: CA Certificates
FROM alpine:latest as certs
RUN apk --update add ca-certificates

# STAGE 2: Dependencies
FROM hashicorp/terraform:1.1.4 as tf

ENV TF_LOG=DEBUG

# Copy Terraform configuration files
COPY ./providers.tf /tf/providers.tf
COPY ./main.tf /tf/main.tf
COPY ./terraform.rc /terraform.rc
COPY ./modules /tf/modules  # If you have local modules

WORKDIR /tf

# Initialize Terraform (download providers and modules)
RUN terraform init -backend=false

# STAGE 3: Packaging
FROM scratch
ENV PATH=/bin
ENV TF_CLI_CONFIG_FILE=/terraform.rc

# Copy CA certificates
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Copy Terraform files and binaries
COPY --from=tf /tf /tf
COPY --from=tf /bin/terraform /bin/terraform

# Copy Terraform CLI configuration
COPY terraform.rc /terraform.rc

WORKDIR /working_dir

