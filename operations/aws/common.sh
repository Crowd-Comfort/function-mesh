# Common code to all of the CodeBuild scripts

export COMMONS_SHELL_DIR=${CODEBUILD_SRC_DIR_commons_shell}
source "${COMMONS_SHELL_DIR}/bash/all.sh"

# Ignore our normal git flow - we're only going to work off master, and we're
# going to treat every PR change like its a merge event, and every merge event
# we'll just back out of (because the PR event should already be built).
# This is nonsense, but we're not really working in our own repo here.

## ONLY build if we're in a PR to develop (QA) or master (PROD) or local (LOCAL)
export ENV=""
if [ "${CODEBUILD_WEBHOOK_BASE_REF-}" == "refs/heads/develop" ] ; then
  export ENV=QA
elif [ "${CODEBUILD_WEBHOOK_BASE_REF-}" == "refs/heads/master" ] ; then
  export ENV=QA
else
  warn "Could not determine environment from base ref '${CODEBUILD_WEBHOOK_BASE_REF}'"
fi

cd "${CODEBUILD_SRC_DIR}"
source "operations/aws/${ENV}.sh"

if [ "${CODEBUILD_WEBHOOK_EVENT-}" == "PULL_REQUEST_MERGED" ] ; then
  info "PR merged.  Assuming done."
  exit 0

  # info "Pull request merged.  Switching git repo to track base reference."
  # cd "${CODEBUILD_SRC_DIR}"

  # if [ "${ENV}" == "QA" ] ; then
  #   # TODO - We should probably make sure the head is a feature branch.
  #   git switch develop
  # elif [ "${ENV}" == "PROD" ] ; then
  #   # TODO - We should probably make sure the head is develop.
  #   git switch master
  # fi
fi

cd "${CODEBUILD_SRC_DIR}"
info "Branches:"
git branch

export LATEST_COMMIT_ID=`git log --format="%H" -n 1`
export IMAGE_TAG_LOCAL="${LATEST_COMMIT_ID}"

info "${BUILD_STAGE} image"
info "  Repository:       ${CODEBUILD_WEBHOOK_REPOSITORY_NAME}"
info "  Pull Request:     ${CODEBUILD_WEBHOOK_HEAD_REF} -> ${CODEBUILD_WEBHOOK_BASE_REF}"
info "  Environment:      ${ENV}"
info "  Latest commit ID: ${LATEST_COMMIT_ID}"
