SCRIPT_DIR=$(realpath $(dirname $0))

git ls-files -s \
  | perl -n $SCRIPT_DIR/matcher.pl
