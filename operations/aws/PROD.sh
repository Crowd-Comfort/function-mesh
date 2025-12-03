# This is meant to be sourced by the other scripts with environment specific
# configuration.

# In prod, we're going to use this CICD secret as well because the image is
# built and tested in the QA VPC.  The file itself shouldn't be in the
# actual image when pushed.

export CONFIG_SECRET_ID=
