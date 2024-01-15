#!/bin/bash
search_path="/home/jackstockley/infrastructure/docker/"
file_extensions=("yml" "yaml", "json")

for ext in "${file_extensions[@]}"; do
    find "$search_path" -type f -name "*.$ext" | while read -r file; do
        mv "$file" "$file.bak"
        while IFS= read -r line; do
            while [[ $line =~ __(.+)__ ]]; do
                var_name=${BASH_REMATCH[1]}
                var_value=${!var_name:-default_value}
                line=${line/__${var_name}__/$var_value}
            done
            echo "$line"
        done < "$file.bak" > "$file"
        rm "$file.bak"
    done
done
