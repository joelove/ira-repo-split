s/\t(\.gitignore)/\tEP\/\1/;
s/\t(\.gitattributes)/\tEP\/\1/;
s/\t(\.eslintrc\.js)/\tEP\/\1/;
s/\t(\.editorconfig)/\tEP\/\1/;
s/\t(\.csscomb\.json)/\tEP\/\1/;
s/\t(\.sass-lint\.yml)/\tEP\/\1/;
s/\t(README\.md)/\tEP\/\1/;

s/\tbuild-webpack\/(.*)/\tEP\/\1/;

s/\tsrc\/Ira\.Website\.Portals\/templates\/employee-([^.]+\.html)/\tEP\/build\/templates\/\1/;
s/\tsrc\/Ira\.Website\.Portals\/favicon\.ico/\tEP\/build\/favicon.ico/;
s/\tsrc\/Ira\.Website\.Portals\/employee\.html/\tEP\/build\/index.html/;
s/\tsrc\/Ira\.Website\.Portals\/(images\/.*)/\tEP\/src\/\1/;

s/\tsrc\/Ira\.Website\.Portals\.Employee\.React\/(scripts\/.*)/\tEP\/src\/\1/;
s/\tsrc\/Ira\.Website\.Portals\.Employee\.React\/README\.md/\tEP\/README_2\.md/;

s/\t(src\/Ira\.Website\.Portals\.Common\/(?!scripts\/ira-portals-common\/(?:controllers\/|models\/|validators\/|views\/|bootstrap)).*)/\tEP\/\1/;

s/\tsrc\/Ira\.Website\.Common\/(sass\/.*)/\tEP\/src\/\1/;

s/\t(tests\/enzyme.js)/\tEP\/\1/;
s/\t(tests\/config)/\tEP\/\1/;
s/\ttests\/employee-portal\/(.*)/\tEP\/tests\/\1/;

print;
