#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

bash ./bin/docker-build.sh
bash ./bin/docker-publish.sh
bash ./bin/docker-run.sh