# CI/CD

This repository is controlled by an AWS CodeBuild project.  The BuildSpec is
common/shared with all of our projects, and can be found here:
  https://github.com/Crowd-Comfort/commons-codebase/blob/develop/operations/aws/buildspec.yml

Specifically, the GitFlow is documented in the README here:
  https://github.com/Crowd-Comfort/commons-codebase/blob/develop/README.md

CodeBuild execution will kick off as follows:

* On PR creation or update to develop, CodeBuild will call into this project
  * build.sh
  * test.sh
  * push.sh
* On PR merge to develop, CodeBuild will call into this project
  * build.sh
  * test.sh
  * push.sh
  * release.sh

Several environment variables will be available to you:

* CODEBUILD_SRC_DIR - the location this repository is checked out to
* CODEBUILD_SRC_DIR_commons_codebuild - the location the commons-codebuild repository is checked out to
* CODEBUILD_SRC_DIR_commons_shell - the location the commons-shell repository is checked out to
* AWS_DEFAULT_REGION - the region resources should default to, e.g. ECR repositories to push to
* AWS_ACCOUNT_ID - the account ID resources should live in
* ECR_REPO_NAME - the Elastic Container Registry repository name to push to
* GIT_REPO_NAME - the name of the git repository currently working with
* CODEBUILD_BUILD_URL - URL for details on the current CodeBuild execution
* CODEBUILD_WEBHOOK_BASE_REF - the ref the PR wants to merge to (e.g. refs/heads/develop)
* CODEBUILD_WEBHOOK_HEAD_REF - the ref the PR wants to merge from (e.g. refs/heads/feature/JIRA-123/my-feature-description)
* CODEBUILD_WEBHOOK_EVENT - the type of event that triggered CodeBuild (e.g. PULL_REQUEST_CREATED)
