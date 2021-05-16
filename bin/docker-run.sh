#!/bin/bash
#{{{ Bash settings
set -o errexit
set -o nounset
set -o pipefail
#}}}
#{{{ Variables
readonly script=$(basename "${0}")
readonly cwd=$PWD
readonly dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
IFS=$'\t\n' # Split on newlines and tabs (but not on spaces)
#}}}
IMAGE_OWNER_NAME="maspio"
IMAGE_SERVICE_NAME="tunnelto"
IMAGE_NAME="$IMAGE_OWNER_NAME/$IMAGE_SERVICE_NAME"
PKG_PATH="$cwd/package.json"
VERSION="0.1.8"

function readVersion() {
  jq ".version" "$PKG_PATH" -r
}

if [[ -f "$PKG_PATH" ]]; then
  VERSION=$(readVersion)
  echo "version $VERSION"
fi

echo "########################################"
echo "## docker run $IMAGE_NAME:v$VERSION ##"
echo "########################################"

docker run --rm --name "$IMAGE_OWNER_NAME-$IMAGE_SERVICE_NAME" -P "$IMAGE_NAME:v$VERSION"
