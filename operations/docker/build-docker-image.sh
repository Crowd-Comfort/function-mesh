#!/bin/bash

set -u
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${SCRIPT_DIR}/../.."
REPO_ROOT_DIR="$(pwd)"

cat /etc/os-release

# Amazon Linux based:
sudo yum update -y
sudo yum install -y make
sudo yum install -y openssl
sudo yum install -y ca-certificates gnupg

# Go maybe already included...?
go version

# If not - you'll need to figure out how to build manually.  As of this
# writing, the yum repo appears to be broken.
# sudo rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
# curl -s https://mirror.go-repo.io/centos/go-repo.repo | sudo tee /etc/yum.repos.d/go-repo.repo
# sudo yum install golang -y

# Linux based:
# apt update -y
# apt install -y golang-go
# apt install -y make
# apt install -y openssl
# apt install -y ca-certificates curl gnupg lsb-release

# If we need the actual Docker CLI:
# install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# chmod a+r /etc/apt/keyrings/docker.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# apt update -y
# apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

make docker-build-arm

docker image ls
