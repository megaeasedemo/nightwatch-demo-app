#!/usr/bin/env bash
# Created by g7tianyi on 03/09/2017

set -e

pushd $(dirname $0) > /dev/null
SCRIPTPATH=$(pwd -P)
popd > /dev/null
SCRIPTFILE=$(basename $0)

COLOR_NONE='\033[0m'
COLOR_INFO='\033[0;36m'
COLOR_ERRO='\033[1;31m'
HINT_ARROW="$(tput bold)☞ $(tput sgr0)"

function info() { echo -e "${HINT_ARROW}${COLOR_INFO}${1}${COLOR_NONE}"; }
function erro() { echo -e "${HINT_ARROW}${COLOR_ERRO}${1}${COLOR_NONE}"; }

################################################################################

info "Build Docker Image megaease/nightwatch-demo"

DOCKER_DIR=${SCRIPTPATH}/../rootfs
cd ${DOCKER_DIR}
mkdir -p demoapp
cp ${SCRIPTPATH}/../index.html ./demoapp/
docker build -t megaease/nightwatch-demo -f ${DOCKER_DIR}/Dockerfile .
