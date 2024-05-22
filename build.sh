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
# docker build -t ${DOCKER_REPO}:datalake-version-${VERSION} ./normalized_datalake
docker buildx build --builder default --load --platform linux/amd64 -t ${DOCKER_REPO}:datalake-version-${VERSION}-amd64 ./normalized_datalake
docker buildx build --builder default --load --platform linux/arm64 -t ${DOCKER_REPO}:datalake-version-${VERSION}-arm64 ./normalized_datalake

echo Building Banking ./banking_core...
# docker build -t ${DOCKER_REPO}:bankingcore-version-${VERSION} ./banking_core
docker buildx build --builder default --load --platform linux/amd64 -t ${DOCKER_REPO}:bankingcore-version-${VERSION}-amd64 ./banking_core
docker buildx build --builder default --load --platform linux/arm64 -t ${DOCKER_REPO}:bankingcore-version-${VERSION}-arm64 ./banking_core

echo Building ./banking_trn_srv...
# docker build -t ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION} ./banking_trn_srv
docker buildx build --builder default --load --platform linux/amd64 -t ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}-amd64 ./banking_trn_srv
docker buildx build --builder default --load --platform linux/arm64 -t ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}-arm64 ./banking_trn_srv

echo Building ./pos...
# docker build -t ${DOCKER_REPO}:pos-version-${VERSION} ./pos
docker buildx build --builder default --load --platform linux/amd64 -t ${DOCKER_REPO}:pos-version-${VERSION}-amd64 ./pos
docker buildx build --builder default --load --platform linux/arm64 -t ${DOCKER_REPO}:pos-version-${VERSION}-arm64 ./pos

echo Pushing images...

docker push ${DOCKER_REPO}:datalake-version-${VERSION}-amd64
docker push ${DOCKER_REPO}:datalake-version-${VERSION}-arm64
docker manifest create ${DOCKER_REPO}:datalake-version-${VERSION} --amend ${DOCKER_REPO}:datalake-version-${VERSION}-amd64 ${DOCKER_REPO}:datalake-version-${VERSION}-arm64
docker manifest push ${DOCKER_REPO}:datalake-version-${VERSION}

docker push ${DOCKER_REPO}:bankingcore-version-${VERSION}-amd64
docker push ${DOCKER_REPO}:bankingcore-version-${VERSION}-arm64
docker manifest create ${DOCKER_REPO}:bankingcore-version-${VERSION} --amend ${DOCKER_REPO}:bankingcore-version-${VERSION}-amd64 ${DOCKER_REPO}:bankingcore-version-${VERSION}-arm64
docker manifest push ${DOCKER_REPO}:bankingcore-version-${VERSION}

docker push ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}-amd64
docker push ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}-arm64
docker manifest create ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION} --amend ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}-amd64 ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}-arm64
docker manifest push ${DOCKER_REPO}:bankingtrnsrv-version-${VERSION}

docker push ${DOCKER_REPO}:pos-version-${VERSION}-amd64
docker push ${DOCKER_REPO}:pos-version-${VERSION}-arm64
docker manifest create ${DOCKER_REPO}:pos-version-${VERSION} --amend ${DOCKER_REPO}:pos-version-${VERSION}-amd64 ${DOCKER_REPO}:pos-version-${VERSION}-arm64
docker manifest push ${DOCKER_REPO}:pos-version-${VERSION}
