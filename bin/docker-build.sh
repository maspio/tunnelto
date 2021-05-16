#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly script=$(basename "${0}")
readonly cwd=$PWD
readonly dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
IFS=$'\t\n' # Split on newlines and tabs (but not on spaces)
#
IMAGE_NAME="maspio/tunnelto"
PKG_PATH="$cwd/package.json"
VERSION="latest"

function fileExists() {
  if [[ -f $1 ]]; then
    echo "file $1 exists"
  fi
}

function dirExists() {
  if [[ -d $1 ]]; then
    echo "dir $1 exists"
  fi
}


function readVersion() {
  jq ".version" "$PKG_PATH" -r
}

if [[ -f "$PKG_PATH" ]]; then
  VERSION=$(readVersion)
  echo "version $VERSION"
fi

echo "######################################"
echo "## docker build $IMAGE_NAME:v$VERSION ##"
echo "######################################"

docker build --no-cache --tag "$IMAGE_NAME:v$VERSION" .
