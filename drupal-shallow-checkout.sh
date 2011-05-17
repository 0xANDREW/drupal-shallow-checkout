#!/bin/bash
#
# Drupal shallow checkout
# Checks out everything from a Drupal tree except sites/default/files
#
# Usage: drupal-shallow-checkout.sh {repos URL} {path}

if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: drupal-shallow-checkout.sh {repos URL} {path}"
    exit 1
fi

svn co "$1" "$2" --depth empty

if [ $? -ne 0 ]; then
    exit 2
fi

cd "$2"

for file in `svn list | grep -v sites`; do
    svn up "$file"
done

svn up sites --depth empty
cd sites
svn up all
svn up default --depth empty
cd default
svn up files --depth empty

for file in `svn list | grep -v files`; do
    svn up "$file"
done
