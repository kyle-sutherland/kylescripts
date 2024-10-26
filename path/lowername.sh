#!/bin/zsh
rename_files() {
  for file in *; do
    local name_lower=${file:l}
    mv "$file" "$name_lower"
    echo "rnamed $file to $name_lower"
  done
}
rename_files
