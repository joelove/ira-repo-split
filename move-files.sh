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

rm -r src/Ira.Website.Portals.Common

# Replace references common folder webpack aliases
COMMON_PATTERN='s/Ira\.Website\.Portals\.Common\/scripts\/ira-portals-common/Ira.Website.Portals.Employee.React\/scripts/';

sed -i "$COMMON_PATTERN" webpack.config.js
sed -i "$COMMON_PATTERN" webpack.test.config.js
sed -i "$COMMON_PATTERN" webpack.production.config.js
