#!/bin/bash

set -u
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${SCRIPT_DIR}/../.."
REPO_ROOT_DIR="$(pwd)"

cat /etc/os-release

apt update -y
apt install -y golang-go
apt install -y make
apt install -y openssl
apt install -y ca-certificates curl gnupg lsb-release

# If we need the actual Docker CLI:
# install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# chmod a+r /etc/apt/keyrings/docker.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# apt update -y
# apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

make docker-build-arm

docker image ls
