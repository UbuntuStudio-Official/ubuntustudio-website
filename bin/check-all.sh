#!/usr/bin/env bash

# back to project root if in bin/
if [[ -f check-all.sh ]]; then
  cd ..
fi

# check python
if ! command -v python3 &> /dev/null; then
  echo "python3 could not be found"
  exit 1
fi

# check 1, file naming
echo "Checking for file naming"
check_result=$(python3 bin/01-check-path.py)
if [[ $check_result != "collisions=0" ]]; then
  echo "Path check failed:"
  echo "$check_result"
  exit 1
fi

# check 2, linking
echo "Checking for broken *.md links..."
echo "if any result, remove the md extension"
grep -rn '\.md)' help/content/ wiki/content/ help/index.md wiki/index.md
echo
echo "if any result, remove the index to use the directory path instead"
echo
grep -rn 'index)' help/content/ wiki/content/ help/index.md wiki/index.md
echo

# check 3, yaml blocks
echo "Checking for yaml blocks"
check_result=$(python3 bin/03-check-block.py)
if [[ $check_result != "remaining_files_with_2plus_triple_dash=0" ]]; then
  echo "Yaml block check failed:"
  echo "$check_result"
  exit 1
fi