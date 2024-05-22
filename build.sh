#!/bin/bash
#
# We could have done the build with *docker-compose build*. But then, docker-compose.yml
# would not work with the pre-built images that we leave on docker hub. We want to make
# docker-compose.yml file as much an "out of the box" experience as possible. So we use this 
# script to build the images it needs and we use *docker-compose up* to just run the app.
#
set -e

DOCKER_REPO=intersystemsdc/irisdemo-demo-fraudprevention
VERSION=`cat ./VERSION`

docker-compose stop
docker-compose rm -f
sudo rm -rf ./advanced_analytics/shared/zeppelin/conf
sudo rm -rf ./advanced_analytics/shared/zeppelin/logs

echo Building ./normalized_datalake...
docker build -t ${DOCKER_REPO}:datalake-version-${VERSION} ./normalized_datalake

echo Building Banking ./banking_core...
docker build -t ${DOCKER_REPO}:bankingcore-version-${VERSION} ./banking_core

echo Building ./banking_trn_srv...
docker build -t ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION} ./banking_trn_srv

echo Building ./pos...
docker build -t ${DOCKER_REPO}:pos-version-${VERSION} ./pos