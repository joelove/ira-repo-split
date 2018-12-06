#!/bin/bash
set -e

SCRIPT_DIR=$(realpath $(dirname $0))

# Configuration variables
WORKING_DIR="/Users/joelove/Projects/antiblanks"
REPO_NAME="ira-employee-portal-prune"

# Ensure we start in the correct directory
cd $WORKING_DIR

# Clone the frontend repo
git clone git@gitlab.internal.iraservices.io:ira/frontend.git $REPO_NAME

# Work inside the freshly cloned repo
cd $REPO_NAME

# Conditionally rewrite commit history into the /EP directory using matcher.pl
UPDATE_INDEX_CMD='GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info'
MOVE_INDEX_FILE_CMD='mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"'

git filter-branch \
  --index-filter " \
    git ls-files -s \
      | perl -n $SCRIPT_DIR/matcher.pl \
      | $UPDATE_INDEX_CMD && $MOVE_INDEX_FILE_CMD" \
  --tag-name-filter cat \
  --prune-empty \
  -- --all

# Rewrite all the files in the /EP directory in to the root and discard the rest
git filter-branch \
  -f \
  --prune-empty \
  --subdirectory-filter EP \
  --tag-name-filter cat \
  -- --all

# Restructure repository contents
source $SCRIPT_DIR/rewrite-path-references.sh
