#!/bin/bash

# Exit on error
set -e

echo "Searching for 'work' directories one level down..."

# Find and delete directories named 'work' directly under top-level subdirectories
find . -mindepth 2 -maxdepth 2 -type d -name "work" -exec rm -rf {} +

echo "All 'work' directories removed."
