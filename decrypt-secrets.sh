#!/bin/bash

#
# For script usage, you must:
# 1) Login to AWS first using 'aws sso login' or environment variables
#    https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html
#
# 2) Export KMS_KEY_ARN="$aws_key_value"
#

set -e  # Exit if any command fails

# Show usage manual
show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

OPTIONS:
  -h, --help        Show this help message

Before running the script, ensure the following environment variable is set:
  - KMS_KEY_ARN     Your AWS KMS key ARN, e.g. arn:aws:kms:region:account-id:key/key-id

Example usage:
  export KMS_KEY_ARN="arn:aws:kms:region:account-id:key/key-id"
  ./decrypt-secrets.sh
EOF
}

# Parse command-line arguments for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_usage
    exit 0
fi

# Check if KMS_KEY_ARN is set
if [[ -z "$KMS_KEY_ARN" ]]; then
    echo "❌ ERROR: KMS_KEY_ARN is not set. Please export it first."
    echo "➡️  Run: export KMS_KEY_ARN=\"your-aws-kms-key-arn\""
    exit 1
fi

# Find all encrypted .sops files and decrypt them
find . -type f -name "secrets.tfvars.sops" -not -path "./.git/*" | while read -r file; do
    DECRYPTED_FILE="${file%.sops}"  # Remove .sops extension

    # Decrypt and overwrite the target file
    if sops --decrypt --kms "$KMS_KEY_ARN" --input-type binary --output-type binary "$file" > "$DECRYPTED_FILE"; then
        echo "✅ Decrypted: $file -> $DECRYPTED_FILE"
    else
        echo "❌ Failed to decrypt: $file" >&2
        exit 1  # Stop execution on failure
    fi
done
