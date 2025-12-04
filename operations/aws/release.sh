#!/bin/bash

set -u
set -e

# This script is called every time a PR is merged to develop/master/local

export BUILD_STAGE="Releasing"
cd "${CODEBUILD_SRC_DIR}"
source "operations/aws/common.sh"

########## SETUP CHECKS ##########

ENV_LOWER=$(echo "${ENV-}" | tr '[:upper:]' '[:lower:]')
ENV_UPPER=$(echo "${ENV-}" | tr '[:lower:]' '[:upper:]')

# Double check that this is for a PR merge event
if [ "${CODEBUILD_WEBHOOK_EVENT}" != "PULL_REQUEST_MERGED" ] ; then
  die "Asked to release image on a non-merge event"
fi

if [ "${ENV_UPPER}" == "PROD" ] ; then
  warn "For now, we aren't implementing CD to production.  Please deploy manually."
  exit 0
fi
if [ "${ENV_UPPER}" != "QA" ] ; then
  die "We are only handling continuous deployment to QA.  Unknown environment ${ENV_UPPER}"
fi

warn "No automatic deployments.  Yet."

info "Release complete."
