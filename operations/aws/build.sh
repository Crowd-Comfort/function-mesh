#!/bin/bash

set -u
set -e

# This script is called every time a PR is created, updated or merged to
# develop/master/local

export BUILD_STAGE="Building"
cd "${CODEBUILD_SRC_DIR}"
source "operations/aws/common.sh"

if [ "${ENV-}" == "" ] ; then
  warn "We are only handling builds for local, develop and master branches."
  exit 0
fi

info "CodeBuild identity (role):"
aws sts get-caller-identity

info "Image tag: ${IMAGE_TAG_LOCAL}"

# Build the image locally
bash operations/docker/build-docker-image.sh

# We're only building a single architecture at the moment.  Consider the rest
# of the script if multiple architectures are needed.
# FIXME - right now this is building as the upstream tag:version.  If we're
#         going to keep this forked, we should have it named ourselves.
docker tag \
    streamnative/function-mesh-operator:v0.25.1 \
    ${ECR_REPO_NAME}:${IMAGE_TAG_LOCAL}

info "Docker images (locally):"
docker image ls
