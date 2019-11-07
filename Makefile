
include .env

build:
	docker-compose stop
	docker-compose rm -f
	sudo rm -rf ./advanced_analytics/shared/zeppelin/conf
	sudo rm -rf ./advanced_analytics/shared/zeppelin/logs

	docker-compose build
clean:
	-docker-compose rm -f
	-docker rmi ${DOCKER_REPOSITORY}:bankingcore-version-${TAG}
	-docker rmi ${DOCKER_REPOSITORY}:bankingtrnsrv-version-${TAG}
	-docker rmi ${DOCKER_REPOSITORY}:datalake-version-${TAG}
	-docker rmi ${DOCKER_REPOSITORY}:pos-version-${TAG}

run:
	docker-compose up