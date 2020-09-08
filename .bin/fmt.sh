#!/bin/sh

find . -type d | grep -e envs -e modules | sed -e '$a\
./' | while read -r DIR;
do
  echo "$DIR"
  tfFiles=$(find "$DIR" -type f -maxdepth 1 -name "*.tf" 2>/dev/null)
  if [ -n "$tfFiles" ]; then
    echo "Format $DIR"
    terraform fmt "$DIR"
  else
    echo "Skip $DIR. Not exists tf file."
  fi
done
