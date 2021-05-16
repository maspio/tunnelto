#!/bin/bash
#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}
#{{{ Variables
readonly script=$(basename "${0}")
readonly cwd=$PWD
readonly dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
IFS=$'\t\n' # Split on newlines and tabs (but not on spaces)
#}}}
#
PKG_PATH="$cwd/package.json"
IMAGE_NAME="maspio/tunnelto"
VERSION="latest"

function readVersion() {
  jq ".version" "$PKG_PATH" -r
}

if [[ -f "$PKG_PATH" ]]; then
  VERSION=$(readVersion)
  echo "version $VERSION"
fi

echo "########################################"
echo "## docker publish $IMAGE_NAME:v$VERSION ##"
echo "########################################"

docker push "$IMAGE_NAME:v$VERSION"
