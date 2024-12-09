#!/usr/bin/env bash

# Updated repo-status script:
# - Prints directories first
# - Lists files second
# - Prints content of files identified as text (including UTF, JSON, etc.)
# - Non-text files are just listed by name

echo "===== Directories ====="
for item in *; do
    if [ -d "$item" ]; then
        echo "### Directory: $item"
    fi
done

echo
echo "===== Files ====="
for item in *; do
    if [ -f "$item" ]; then
        # Use 'file' command to determine type
        # We'll consider the file 'printable' if it matches common text indicators.
        # This includes 'text', 'JSON', 'ASCII', 'Unicode', etc.
        # The 'file' command often identifies JSON as ASCII text or JSON data, which we'll allow.
        file_type=$(file "$item")

        if echo "$file_type" | grep -Eiq 'text|ascii|utf-8|unicode|json'; then
            # Print file contents with delimiters
            echo
            echo "----- BEGIN FILE: $item -----"
            cat "$item"
            echo "----- END FILE: $item -----"
        else
            # Just list the file if it's not recognized as text
            echo "$item (non-text file)"
        fi
    fi
done