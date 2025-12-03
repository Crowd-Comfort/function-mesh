# Settings here can impact the overall CodeBuild execution framework.
# In general, things here should not be monkeyed with unless you know what
# you're doing.

# Disables reporting of slack status during build.  Please don't merge this
# turned off to develop or master, and please reject code reviews that have
# this off.
export CODEBUILD_REPORT_SLACK=false
