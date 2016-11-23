This is your first step.

## Task

This is an _example_ of creating a scenario and running a **command**

`echo 'Hello World'`{{execute}}


Below is just Test you don't need to Go..

## Install Docker compose

```curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > ./docker-compose```{{execute}}

`chmod +x ./docker-compose && sudo mv ./docker-compose /usr/local/bin/docker-compose`{{execute}}


voila

```curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > ./docker-compose \
   chmod +x ./docker-compose && sudo mv ./docker-compose /usr/local/bin/docker-compose```{{execute}}




## Install Docker 1.12

`sudo apt-get update`{{execute}} et `sudo apt-get install -y docker-engine`{{execute}}.
Check that install is ok `docker -v`{{execute}}

```sudo apt-get update \
   sudo apt-get install -y docker-engine \
   docker -v```{{execute}}

## Clone the vote microservice stack

`git clone https://github.com/philipz/example-voting-app`{{execute}}

git clone https://github.com/bfirsh/serverless-docker-voting-app


# Credits

https://www.katacoda.com/philipz/
https://github.com/philipz/docker_workshop
https://philipz.github.io/vote_microservice.html
https://www.katacoda.com/mesoshq

https://github.com/inyoungcho/katacoda-scenarios
https://www.katacoda.com/inyoungcho

machine:
  image: 
  labels:
    - "traefik.backend=machine-echo"
    - "traefik.frontend.rule=Host:machine-echo.example.com"
	
echo:
  image: katacoda/docker-http-server:v2
  labels:
    - "traefik.backend=echo"
    - "traefik.frontend.rule=Host:echo-echo.example.com"
	
curl -H Host:machine-echo.example.com http://host01	


docker-compose scale machine=2 

