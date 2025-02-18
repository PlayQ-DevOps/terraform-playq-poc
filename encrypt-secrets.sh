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
Usage: $0 [OPTIONS] <filename>

OPTIONS:
  -h, --help        Show this help message

ARGS:
  <filename>        The file to encrypt (or 'all' to encrypt all 'secrets.tfvars' files)

Before running the script, ensure the following environment variable is set:
  - KMS_KEY_ARN     Your AWS KMS key ARN, e.g. arn:aws:kms:region:account-id:key/key-id

Example usage:
  export KMS_KEY_ARN="arn:aws:kms:region:account-id:key/key-id"
  $0 secrets.tfvars
  $0 all
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

# Check if a filename argument is provided
if [[ -z "$1" ]]; then
    echo "❌ ERROR: No filename provided. Usage: $0 <filename> or 'all'"
    show_usage
    exit 1
fi

TEMP_FILES=()  # Array to track created .sops files

# Determine target files
if [[ "$1" == "all" ]]; then
    FILES=$(find . -type f -name "secrets.tfvars" -not -path "./.git/*")
else
    FILES="$1"
    if [[ ! -f "$FILES" ]]; then
        echo "❌ ERROR: File '$FILES' does not exist."
        exit 1
    fi
fi

# Encrypt each file
for file in $FILES; do
    OUTPUT_FILE="$file.sops"

    # Encrypt and check if successful
    if sops --encrypt --input-type binary --output-type binary --kms "$KMS_KEY_ARN" "$file" > "$OUTPUT_FILE"; then
        echo "✅ Encrypted: $file -> $OUTPUT_FILE"
        git add "$OUTPUT_FILE"
        TEMP_FILES+=("$OUTPUT_FILE")  # Track created file
    else
        echo "❌ Failed to encrypt: $file" >&2

        # Undo previous changes
        for temp_file in "${TEMP_FILES[@]}"; do
            rm -f "$temp_file"  # Remove created .sops file
            git restore --staged "$temp_file"  # Unstage it from Git
        done

        exit 1  # Stop commit
    fi
done
