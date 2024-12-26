#!/bin/bash

set -eux

folder_path="lib/"

file_name=$(find "$folder_path" -maxdepth 1 -type f)
file_name=$(basename "$file_name")

rm -rf "$folder_path""$file_name"

dart run build_runner build

mv "$folder_path""export.dart" "$folder_path""$file_name"