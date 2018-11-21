REPO_DIR="ira-employee-portal-prune-2"

# Clone the frontend repo
git clone git@gitlab.internal.iraservices.io:ira/frontend.git $REPO_DIR

# Change directory
cd $REPO_DIR

# Rewrite all the git files matching these patterns into the /EP directory
git filter-branch --index-filter ' \
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

# Rewrite all the files in the /EP folder in to the root and discard the rest
git filter-branch -f \
--prune-empty \
--subdirectory-filter ep \
--tag-name-filter cat \
-- --all
