#!/bin/bash
set -e

WORKING_DIR="/Users/joelove/Projects/antiblanks"
REPO_NAME="ira-employee-portal-prune"

# Ensure we start in the correct directory
cd $WORKING_DIR

# Clone the frontend repo
git clone git@gitlab.internal.iraservices.io:ira/frontend.git $REPO_NAME

# Work inside the freshly cloned repo
cd $REPO_NAME

# Rewrite all the git files matching these patterns into the /EP directory
git filter-branch \
  --index-filter ' \
    git ls-files -s \
      | perl -ne " \
        s/\t(\.gitignore)/\tEP\/\1/; \
        s/\t(\.gitattributes)/\tEP\/\1/; \
        s/\t(\.eslintrc\.js)/\tEP\/\1/; \
        s/\t(\.editorconfig)/\tEP\/\1/; \
        s/\t(\.csscomb\.json)/\tEP\/\1/; \
        s/\t(\.sass-lint\.yml)/\tEP\/\1/; \
        s/\t(README\.md)/\tEP\/\1/; \
        s/\tbuild-webpack\/(.*)/\tEP\/\1/; \
        s/\t(src\/Ira\.Website\.Portals\.Employee\.React\/.*)/\tEP\/\1/; \
        s/\t(src\/Ira\.Website\.Portals\.Common\/(?!scripts\/ira-portals-common\/(?:controllers\/|models\/|validators\/|views\/|bootstrap)).*)/\tEP\/\1/; \
        s/\t(src\/Ira\.Website\.Portals\/(?!scripts\/).*)/\tEP\/\1/; \
        s/\t(src\/Ira\.Website\.Portals\/scripts\/ira-modules\/.*)/\tEP\/\1/; \
        s/\t(src\/Ira\.Website\.Common\/sass\/.*)/\tEP\/\1/; \
        s/\t(tests\/enzyme.js)/\tEP\/\1/; \
        s/\t(tests\/config)/\tEP\/\1/; \
        s/\ttests\/employee-portal\/(.*)/\tEP\/tests\/\1/; \
        print;" \
      | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info \
    && mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' \
  --tag-name-filter cat \
  --prune-empty \
  -- --all

# Rewrite all the files in the /EP directory in to the root and discard the rest
git filter-branch \
  -f \
  --prune-empty \
  --subdirectory-filter ep \
  --tag-name-filter cat \
  -- --all

# Rewrite relative references to /src directory in 5 files
sed -i 's/\.\.\/src/\.\/src/' dev-server.js
sed -i 's/\.\.\/src/\.\/src/' package.json
sed -i 's/\.\.\/src/\.\/src/' webpack.config.js
sed -i 's/\.\.\/src/\.\/src/' webpack.production.config.js
sed -i 's/\.\.\/src/\.\/src/' webpack.test.config.js
