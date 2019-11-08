@ECHO OFF

echo Updating sub modules...
git submodule init
git submodule update

echo BUILDING...
docker-compose stop
docker-compose rm -f

rd /s /q .\advanced_analytics\shared\zeppelin\conf
rd /s /q .\advanced_analytics\shared\zeppelin\logs

docker-compose build