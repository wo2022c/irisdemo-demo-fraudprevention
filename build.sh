#!/bin/bash

set -e

printf "\nUpdating sub modules...\n"
git submodule init
git submodule update

docker-compose stop
docker-compose rm -f
sudo rm -rf ./advanced_analytics/shared/zeppelin/conf
sudo rm -rf ./advanced_analytics/shared/zeppelin/logs

docker-compose build