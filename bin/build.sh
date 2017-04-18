#!/usr/bin/bash

RELEASES_DIR=/home/git/releases
GITEA_REPO=https://github.com/unfoldingWord-dev/gogs.git
CUSTOM_REPO=https://github.com/unfoldingWord-dev/gogs-custom.git

set -e

version=$1 # THIS NEEDS TO BE THE VERSION WE ARE MAKING WITHOUT the "v", e.g. 1.0.0

# MAKE A TEMP go DIRECTORY
cd $(mktemp -d /tmp/go-XXXX)

# SET GO PATHS FOR COMPILING
export GOPATH=$(pwd)
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

# COMPILE GITEA FROM OUR GITEA_REPO
go get -d -u code.gitea.io/gitea
cd code.gitea.io
rm -rf gitea
git clone --branch master ${GITEA_REPO} gitea
cd gitea
TAGS="bindata" make generate build

# SET GITEA PATH
export GITEA_PATH=${GOPATH}/src/code.gitea.io/gitea

# MAKE THE RELEASE DIR
rm -rf ${RELEASES_DIR}/${version}
RELEASE_PATH=${RELEASES_DIR}/${version}/gogs
mkdir -p ${RELEASE_PATH}

# COPY IN gitea and make custom dir from $CUSTOM_REPO
cp ${GITEA_PATH}/gitea ${RELEASE_PATH}
git clone --branch master ${CUSTOM_REPO} "${RELEASE_PATH}/custom" && rm -rf "${RELEASE_PATH}/custom/.git*"

# TAR IT UP
tar -cvzf ${RELEASES_DIR}/linux_amd64_${version}.tar.gz -C ${RELEASES_DIR}/${version} gogs
