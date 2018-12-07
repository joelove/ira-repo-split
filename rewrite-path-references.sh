echo 'Update relative references to /src folder...'
SRC_PATTERN='s/\.\.\/src/\.\/src/';
sed -i "$SRC_PATTERN" dev-server.js
sed -i "$SRC_PATTERN" package.json
sed -i "$SRC_PATTERN" webpack.config.js
sed -i "$SRC_PATTERN" webpack.production.config.js
sed -i "$SRC_PATTERN" webpack.test.config.js

echo 'Updating Webpack references for SASS...'
SASS_PATTERN='s/Ira\.Website\.Common\/sass/sass/';
sed -i "$SASS_PATTERN" webpack.config.js
sed -i "$SASS_PATTERN" webpack.test.config.js
sed -i "$SASS_PATTERN" webpack.production.config.js

echo 'Updating Webpack references for images...'
IMAGES_PATTERN='s/Ira\.Website\.Portals\/images/images/';
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
OUTPUT_PATTERN='s/src\/Ira\.Website\.Portals\/employee\.html/build\/index.html/'
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

echo 'Updating SASS index references...'
SASS_INDEX_PATTERN='s/sass\/index\.scss/..\/sass\/index.scss/'
sed -i "$SASS_INDEX_PATTERN" src/scripts/index.js

echo 'Updating grid index references...'
GRID_INDEX_IMPORT_PATTERN='s/components\/grid'\''/components\/grid\/index'\''/'
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/grid.jsx
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/grid/fields/contact-information-field.jsx
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/grid/fields/simple-list-field.jsx
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/grid/grid-column-headers.jsx
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/grid/grid-row.jsx
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/grid/grid-rows.jsx
sed -i "$GRID_INDEX_IMPORT_PATTERN" src/scripts/components/panels/account/account-required-actions/account-required-actions-summary.jsx

echo 'Updating withPermits HOC index references...'
WITH_PERMITS_IMPORT_PATTERN='s/import { withPermits } from '\''portals-common\/components\/hocs'\''/import withPermits from '\''portals-common\/components\/hocs\/with-permits'\''/'
sed -i "$WITH_PERMITS_IMPORT_PATTERN" src/scripts/components/grid.jsx

echo 'Updating withModal HOC references...'
WITH_MODAL_IMPORT_PATTERN='s/import { withModal } from '\''portals-common\/components\/hocs'\''/import withModal from '\''portals-common\/components\/hocs\/with-modal'\''/'
sed -i "$WITH_MODAL_IMPORT_PATTERN" src/scripts/components/grid/fields/components/custodian-account-modal.jsx
sed -i "$WITH_MODAL_IMPORT_PATTERN" src/scripts/components/ip-range/buttons/delete-ip-range-button.jsx
sed -i "$WITH_MODAL_IMPORT_PATTERN" src/scripts/components/user-management/buttons/set-user-email-button.jsx
sed -i "$WITH_MODAL_IMPORT_PATTERN" src/scripts/components/user-management/buttons/set-user-password-button.jsx
sed -i "$WITH_MODAL_IMPORT_PATTERN" src/scripts/components/user-management/buttons/suspend-user-button.jsx
sed -i "$WITH_MODAL_IMPORT_PATTERN" src/scripts/components/user-management/buttons/unsuspend-user-button.jsx

echo 'Merging READMEs...'
cat README_2.md >> README.md
rm README_2.md

echo 'Updating dist folder...'
DIST_PATTERN='s/src\/Ira\.Website\.Portals'\''/dist'\''/'
sed -i "$DIST_PATTERN" webpack.production.config.js

echo 'Updating output JS filename...'
JS_OUTPUT_PATTERN='s/scripts\/ira-modules\/ira-portals-employee\.min\.js/employee-portal.min.js/'
sed -i "$JS_OUTPUT_PATTERN" webpack.production.config.js

echo 'Updating output CSS path...'
CSS_OUTPUT_PATTERN='s/css\/employee-portal\.min\.css/employee-portal.min.css/'
sed -i "$CSS_OUTPUT_PATTERN" webpack.production.config.js

echo 'Updating output CSS path...'
CSS_OUTPUT_PATTERN='s/employee\.aspx/employee-portal.aspx/'
sed -i "$CSS_OUTPUT_PATTERN" webpack.production.config.js

echo 'Updating build template...'
BUILD_TEMPLATE_PATTERN='s/src\/Ira\.Website\.Portals\/templates\/employee-main\.html/build\/templates\/main\.html/'
sed -i "$BUILD_TEMPLATE_PATTERN" webpack.production.config.js

echo 'Updating build path in templates...'
BUILD_PATH_PATTERN='s/..\/build-webpack//'
BUILD_EMPLOYEE_PATTERN='s/employee-//'
sed -i "$BUILD_PATH_PATTERN" build/templates/main.html
sed -i "$BUILD_EMPLOYEE_PATTERN" build/templates/main.html

echo 'Updating node modules path in .csscomb.json...'
BUILD_CSS_PATTERN='s/build\///'
BUILD_WEBPACK_CSS_PATTERN='s/build-webpack\///'
sed -i "$BUILD_CSS_PATTERN" .csscomb.json
sed -i "$BUILD_WEBPACK_CSS_PATTERN" .csscomb.json
