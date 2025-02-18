#!/bin/bash

#
# For script usage You have to login to AWS first
# 'aws sso login' command or use env vars for aws login
# https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html
#

set -e  # Exit if any command fails

# Find all encrypted .sops files and decrypt them
find . -type f -name "secrets.tfvars.sops" -not -path "./.git/*" | while read -r file; do
    DECRYPTED_FILE="${file%.sops}"  # Remove .sops extension

    # Decrypt and overwrite the target file
    if sops --decrypt --kms $KMS_KEY_ARN --input-type binary --output-type binary "$file" > "$DECRYPTED_FILE"; then
        echo "Decrypted: $file -> $DECRYPTED_FILE"
    else
        echo "Failed to decrypt: $file" >&2
        exit 1  # Stop execution on failure
    fi
done
