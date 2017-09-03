#!/usr/bin/env bash
# Created by g7tianyi on 03/09/2017

set -e

pushd $(dirname $0) > /dev/null
SCRIPTPATH=$(pwd -P)
popd > /dev/null
SCRIPTFILE=$(basename $0)

################################################################################

DOCKER_DIR=${SCRIPTPATH}/../rootfs
cd ${DOCKER_DIR}
mkdir -p demoapp
cp ${SCRIPTPATH}/../index.html ./demoapp/
docker build -t megaease/nightwatch-demo -f ${DOCKER_DIR}/Dockerfile .
