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

# Replace relative references to /src directory in dev server, package.json and webpack configs
SRC_PATTERN='s/\.\.\/src/\.\/src/';

sed -i "$SRC_PATTERN" dev-server.js
sed -i "$SRC_PATTERN" package.json
sed -i "$SRC_PATTERN" webpack.config.js
sed -i "$SRC_PATTERN" webpack.production.config.js
sed -i "$SRC_PATTERN" webpack.test.config.js

# Move the sass folder and remove Ira.Website.Common
mv src/Ira.Website.Common/sass src/Ira.Website.Portals.Employee.React
rm -r src/Ira.Website.Common

# Replace references to Ira.Website.Common/sass in in webpack configs
SASS_PATTERN='s/Ira\.Website\.Common\/sass/Ira.Website.Portals.Employee.React\/sass/';

sed -i "$SASS_PATTERN" webpack.config.js
sed -i "$SASS_PATTERN" webpack.test.config.js
sed -i "$SASS_PATTERN" webpack.production.config.js

# Move common scripts to Employee.React folder
rsync -avh --progress --ignore-existing src/Ira.Website.Portals.Common/scripts/ira-portals-common/ src/Ira.Website.Portals.Employee.React/scripts/

# Merge conflicting index files
cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/components/grid/fields/index.js \
  src/Ira.Website.Portals.Employee.React/scripts/components/grid/fields/index.js \
  > src/Ira.Website.Portals.Employee.React/scripts/components/grid/fields/index.js

cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/components/index.js \
  src/Ira.Website.Portals.Employee.React/scripts/components/index.js \
  > src/Ira.Website.Portals.Employee.React/scripts/components/index.js

cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/components/panels/index.js \
  src/Ira.Website.Portals.Employee.React/scripts/components/panels/index.js \
  > src/Ira.Website.Portals.Employee.React/scripts/components/panels/index.js

cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/containers/index.js \
  src/Ira.Website.Portals.Employee.React/scripts/containers/index.js \
  > src/Ira.Website.Portals.Employee.React/scripts/containers/index.js

# Remove common folder
rm -r src/Ira.Website.Portals.Common

# Replace references common folder webpack aliases
COMMON_PATTERN='s/Ira\.Website\.Portals\.Common\/scripts\/ira-portals-common/Ira.Website.Portals.Employee.React\/scripts/';

sed -i "$COMMON_PATTERN" webpack.config.js
sed -i "$COMMON_PATTERN" webpack.test.config.js
sed -i "$COMMON_PATTERN" webpack.production.config.js
