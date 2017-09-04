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

IMAGE_NAME="nightwatch-demo"
DOCKER_IMAGE="dockerhub.megaease.com/megaease/${IMAGE_NAME}"
DOCKER_CONTAINER_NAME="demo-app"

function stop_instance() {

    info "Stop Instance"
    docker stop $(docker ps -a | grep ${DOCKER_CONTAINER_NAME} | awk '{print $1}') || /bin/true

}

function start_instance() {

    info "Pull Docker Image"
    IMAGE=""
    if [ -z "${IMAGE_VERSION}" ]; then
        docker rmi $(docker images | grep 'nightwatch-demo') || /bin/true
        IMAGE="${DOCKER_IMAGE}"
    else
        IMAGE="${DOCKER_IMAGE}:${IMAGE_VERSION}"
    fi
    docker pull ${IMAGE}

    info "Start Instance"
    docker run --name ${DOCKER_CONTAINER_NAME} -d -p 80:80 ${IMAGE}

}

stop_instance
start_instance
