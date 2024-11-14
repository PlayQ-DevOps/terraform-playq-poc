# STAGE 1: CA Certificates
FROM alpine:latest as certs
RUN apk --update add ca-certificates

# STAGE 2: Dependencies
FROM hashicorp/terraform:1.5.7 as tf

ENV TF_LOG=DEBUG

COPY ./providers.tf /tf/providers.tf
COPY ./main.tf /tf/main.tf
COPY ./modules /tf/modules 

WORKDIR /tf

# download providers and modules...providers mirror
RUN terraform init -backend=false

# STAGE 3: Packaging artifcat
FROM scratch
ENV PATH=/bin

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=tf /tf /tf
COPY --from=tf /bin/terraform /bin/terraform

WORKDIR /working_dir

