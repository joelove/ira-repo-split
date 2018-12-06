echo 'Update relative references to /src folder...'
SRC_PATTERN='s/\.\.\/src/\.\/src/';
sed -i "$SRC_PATTERN" dev-server.js
sed -i "$SRC_PATTERN" package.json
sed -i "$SRC_PATTERN" webpack.config.js
sed -i "$SRC_PATTERN" webpack.production.config.js
sed -i "$SRC_PATTERN" webpack.test.config.js

echo 'Updating Webpack references for SASS...'
SASS_PATTERN='s/Ira\.Website\.Common\/sass/src\/sass/';
sed -i "$SASS_PATTERN" webpack.config.js
sed -i "$SASS_PATTERN" webpack.test.config.js
sed -i "$SASS_PATTERN" webpack.production.config.js

echo 'Updating Webpack references for images...'
IMAGES_PATTERN='s/Ira\.Website\.Portals\/images/src\/images/';
sed -i "$IMAGES_PATTERN" webpack.config.js
sed -i "$IMAGES_PATTERN" webpack.test.config.js
sed -i "$IMAGES_PATTERN" webpack.production.config.js

echo 'Combining scripts folders...'
rsync -avh --progress --ignore-existing src/Ira.Website.Portals.Common/scripts/ira-portals-common/ src/scripts/

echo 'Merging index files...'
cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/components/grid/fields/index.js \
  >> src/scripts/components/grid/fields/index.js
cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/components/index.js \
  >> src/scripts/components/index.js
cat src/Ira.Website.Portals.Common/scripts/ira-portals-common/components/panels/index.js \
  >> src/scripts/components/panels/index.js
cat \
  src/Ira.Website.Portals.Common/scripts/ira-portals-common/containers/index.js \
  >> src/scripts/containers/index.js

echo 'Removing common folder...'
rm -r src/Ira.Website.Portals.Common

echo 'Updating webpack config for common scripts...'
COMMON_PATTERN='s/Ira\.Website\.Portals\.Common\/scripts\/ira-portals-common/scripts/';
sed -i "$COMMON_PATTERN" webpack.config.js
sed -i "$COMMON_PATTERN" webpack.test.config.js
sed -i "$COMMON_PATTERN" webpack.production.config.js

echo 'Updating .csscomb.json...'
NODE_MODULES_PATTERN='s/"build\/node_modules\/\*\*",\s*"build-webpack\/node_modules\/\*\*"/"node_modules\/\*\*"/'
sed -i "$NODE_MODULES_PATTERN" .csscomb.json

echo 'Writing new .gitignore...'
echo 'node_modules/' > .gitignore
echo 'coverage' >> .gitignore
echo '.nyc_output' >> .gitignore
echo 'dist/' >> .gitignore

echo 'Updating content base...'
CONTENT_BASE_PATTERN='s/src\/Ira\.Website\.Portals/src/'
sed -i "$CONTENT_BASE_PATTERN" dev-server.js

echo 'Updating package name...'
NAME_PATTERN='s/build-webpack/employee-portal/'
sed -i "$NAME_PATTERN" package.json

echo 'Updating entry point...'
ENTRY_PATTERN='s/Ira\.Website\.Portals\.Employee\.React\/scripts\/index\.js/scripts\/index.js/'
sed -i "$ENTRY_PATTERN" webpack.config.js
sed -i "$ENTRY_PATTERN" webpack.test.config.js
sed -i "$ENTRY_PATTERN" webpack.production.config.js

echo 'Updating webpack output path...'
OUTPUT_PATTERN='s/src\/Ira\.Website\.Portals\/employee\.html/build/index.html/'
sed -i "$OUTPUT_PATTERN" webpack.config.js
sed -i "$OUTPUT_PATTERN" webpack.test.config.js
sed -i "$OUTPUT_PATTERN" webpack.production.config.js

echo 'Update webpack aliases...'
SASS_PATTERN='s/Ira\.Website\.Portals\.Employee\.React\/sass/sass/'
IMAGES_PATTERN='s/Ira\.Website\.Portals\.Employee\.React\/images/images/'
SCRIPTS_PATTERN='s/Ira\.Website\.Portals\.Employee\.React\/scripts/scripts/'
sed -i "$SASS_PATTERN" webpack.config.js
sed -i "$IMAGES_PATTERN" webpack.config.js
sed -i "$SCRIPTS_PATTERN" webpack.config.js
sed -i "$SASS_PATTERN" webpack.test.config.js
sed -i "$IMAGES_PATTERN" webpack.test.config.js
sed -i "$SCRIPTS_PATTERN" webpack.test.config.js
sed -i "$SASS_PATTERN" webpack.production.config.js
sed -i "$IMAGES_PATTERN" webpack.production.config.js
sed -i "$SCRIPTS_PATTERN" webpack.production.config.js
