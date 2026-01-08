#!/bin/bash
# zowe_operations.sh
# Convert username to lowercase
set -x
LOWERCASE_USERNAME=$(echo "$ZOWE_OPT_USER" | tr '[:upper:]' '[:lower:]')

# Check if directory exists, create if it doesn't
if ! zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" &>/dev/null; then
    echo "Directory does not exist. Creating it..."
    zowe zos-files create uss-directory /z/$LOWERCASE_USERNAME/cobolcheck
else
        echo "Directory already exists."
fi

# Upload files
zowe zos-files upload dir-to-uss "./cobol-check" "/z/$LOWERCASE_USERNAME/cobolcheck" --recursive --attrs .zosattributes

# Verify upload
echo "Verifying upload:"
zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck"
