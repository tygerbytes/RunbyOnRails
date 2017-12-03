#!/usr/bin/env bash

if [ -z ${DEPLOY_DIR+x} ]; then 
    echo "DEPLOY_DIR not set"
    exit
fi

PROJECT_DIRECTORY=`git rev-parse --show-toplevel`
PROJECT_NAME=`basename ${PROJECT_DIRECTORY}`

DEPLOY_SCRIPT="${DEPLOY_DIR}/${PROJECT_NAME}/deploy.sh"

if [ ! -f ${DEPLOY_SCRIPT} ]; then
    echo "Could not find a deploy script at ${DEPLOY_SCRIPT}"
    exit
fi

echo "Executing deploy script at ${DEPLOY_SCRIPT}"

eval "${DEPLOY_SCRIPT} $@"
