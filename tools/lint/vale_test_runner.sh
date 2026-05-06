#!/bin/bash
# Runner script for Vale markdown linting test

# Exit on error
set -e

# Find the vale binary in the runfiles
# We look in the parent directory as well because external repos are siblings to _main
VALE_BIN=$(find -L .. -name vale -type f | head -n 1)

if [ -z "$VALE_BIN" ]; then
    echo "Error: vale binary not found"
    find -L .. -maxdepth 2
    exit 1
fi

echo "Using vale binary: $VALE_BIN"

FILES_TO_LINT=""
for arg in "$@"; do
    if [[ "$arg" == *.md ]] && [ -f "$arg" ]; then
        FILES_TO_LINT="$FILES_TO_LINT $arg"
    fi
done

# Run vale on the provided arguments
# We use --config to point to the .vale.ini file
"$VALE_BIN" --config=".vale.ini" $FILES_TO_LINT
