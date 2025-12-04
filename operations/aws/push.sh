#!/bin/bash

set -u
set -e

# This script is called every time a PR is created, updated or merged to
# develop/master/local

export BUILD_STAGE="Pushing"
cd "${CODEBUILD_SRC_DIR}"
source "operations/aws/common.sh"

# Image should already be built for us by the build.sh script

# Tag the image and push to ECR

# Only push the commit hash tag.
# We don't want to push QA-latest or PROD-latest - if we do, there's a chance
# that image winds up pulled into QA/PROD before we've actually merged and
# intend to release.

echo "Pushing"
export ECR_REMOTE="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}"
export IMAGE_TAG_REMOTE_ID="${ECR_REMOTE}:${LATEST_COMMIT_ID}"
echo "Remote image tag (ID): ${IMAGE_TAG_REMOTE_ID}"
docker tag ${ECR_REPO_NAME}:${IMAGE_TAG_LOCAL} ${IMAGE_TAG_REMOTE_ID}
docker push ${IMAGE_TAG_REMOTE_ID}

info "Docker images (locally):"
docker image ls
