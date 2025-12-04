#!/bin/bash

set -u
set -e

# This script is called every time a PR is created, updated or merged to
# develop/master/local

export BUILD_STAGE="Testing"
cd "${CODEBUILD_SRC_DIR}"
source "operations/aws/common.sh"

# Image should already be built for us by the build.sh script

# Test container
# FIXME - we do actually have tests, lets run them in CodeBuild
echo "No automated tests yet."

echo "Tests complete."
