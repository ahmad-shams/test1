
setlocal

set docker_files_dir=%~dp0
cd %docker_files_dir%
set my_app=%CD%



for /F %%i in ('docker ps -a --filter "name=node-docker"') do (
	if NOT "CONTAINER" == "%%i" set container_id=%%i
)
echo container_id = %container_id%

docker start %container_id%


if NOT "%container_id%" == "" goto :run_bach


docker run --name=node-docker  -d -p 3005:3005 -v %my_app%:/my_app node bash

for /F %%i in ('docker ps --filter "name=node-docker"') do (
	if NOT "CONTAINER" == "%%i" set container_id=%%i
)
echo container_id = %container_id%



:run_bach
docker exec -it %container_id% bash

