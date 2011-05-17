#!/bin/bash
#
# Drupal shallow checkout
# Checks out everything from a Drupal tree except sites/default/files
#
# Usage: drupal-shallow-checkout.sh {repos URL} {path}

svn co "$1" "$2" --depth empty

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
