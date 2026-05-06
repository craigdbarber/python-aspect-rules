#!/bin/bash
# Runner script for Vale markdown linting test

# Exit on error
set -e

# The first argument is the path to the vale binary
VALE_BIN="$1"
shift

if [ -z "$VALE_BIN" ] || [ ! -f "$VALE_BIN" ]; then
    echo "Error: vale binary not found at '$VALE_BIN'"
    exit 1
fi

if [ ! -x "$VALE_BIN" ]; then
    chmod +x "$VALE_BIN"
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
