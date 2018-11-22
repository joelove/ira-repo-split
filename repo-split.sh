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

# Define file index commands for index filter
UPDATE_INDEX_CMD='GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info'
MOVE_INDEX_FILE_CMD='mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"'

# Rewrite all the git files matching these patterns into the /EP directory
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

# Rewrite relative references to /src directory in 5 files
sed -i 's/\.\.\/src/\.\/src/' dev-server.js
sed -i 's/\.\.\/src/\.\/src/' package.json
sed -i 's/\.\.\/src/\.\/src/' webpack.config.js
sed -i 's/\.\.\/src/\.\/src/' webpack.production.config.js
sed -i 's/\.\.\/src/\.\/src/' webpack.test.config.js
