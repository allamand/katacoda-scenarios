

## Define Traefik Container

This scenario uses Docker Compose to define the architecture, and docker Container labels to define the matadata and rules for routing traefik to real microservices apps.

**Traefik** Is a Load Balancer that can listen to docker events to be able to dynamically be configured when container are started/stopped on a Docker Host, or within a Docker Swarm Cluster.

To make it simpler, for this demo we will only be using 1 docker Host.

### Create Traefik Container

We start creating the Docker Compose file by first defining the load balancer:

```
traefik:
  image: traefik
  command: --web --docker --docker.domain=docker.localhost --logLevel=DEBUG
  ports:
    - "80:80"
    - "8080:8080"
    - "443:443"
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    - /dev/null:/traefik.toml
```

The Load Balancer is configured to listen on port 80,443 HTTP traefik, and also procide a web dashboard that is exposed on port 8080.

The use of docker.sok allows traefik to listen to the Docker Host Daemon events, and reconfigure itself when containers are started/stopped. 
>To work with a swarm cluster with TLS security layer, the configuration to launch the Traefik container will be sifferent.


## Define service container

With the Traefik load balancer configured to listen and proxy traffic to containers, based on thecontainers's metadatas, we need to configure thoses metadata as docker labels:

### Define a proxification labels example.

Launch the LoadBalancer

`docker-compose up -d`{{execute}}

you can access the dashboard using :
- https://[[CLIENT_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com
- https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com



## Install Docker compose

```curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > ./docker-compose```{{execute}}

`chmod +x ./docker-compose && sudo mv ./docker-compose /usr/local/bin/docker-compose`{{execute}}


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
  image: katacoda/docker-http-server
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

https://2886795288-8080-ollie01.environments.katacoda.com/dashboard/#/
https://2886795305-8080-ollie01.environments.katacoda.com/
