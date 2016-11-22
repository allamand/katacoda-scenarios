

## Define Traefik Container

This scenario uses Docker Compose to define the architecture, and docker Container labels to define the matadata and rules for routing traefik to real microservices apps.

**Traefik** Is a Load Balancer that can listen to docker events to be able to dynamically be configured when container are started/stopped on a Docker Host, or within a Docker Swarm Cluster.

To make it simpler, for this demo we will only be using 1 docker Host.

### Create Traefik Container

We start creating the Docker Compose file by first defining the load balancer:

<pre class="file" data-filename="docker-compose.yml" data-target="replace">
version: "2"
services:
  traefik:
    image: traefik
    command: --web --docker --docker.domain=docker.localhost --logLevel=DEBUG
    ports:
      - "80:80"
      - "8080:8080"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /dev/null:/traefik.toml</pre>


Now we add Network definitions:
<pre class="file" data-filename="docker-compose.yml" data-target="append">
    networks:
	  - net

networks:
  net:
</pre>

This allow to use a docker network to plus the container on.

## Launch the LoadBalancer

`docker-compose -p traefik up -d`{{execute}}

The Load Balancer is configured to listen on port 80,443 HTTP traefik, and also procide a web dashboard that is exposed on port 8080.

The use of docker.sok allows traefik to listen to the Docker Host Daemon events, and reconfigure itself when containers are started/stopped. 
>To work with a swarm cluster with TLS security layer, the configuration to launch the Traefik container will be different.

Check docker networks `docker network ls`{{execute}}. You can see that a specific network **traefik_net** has been created.

Later If we want others containers to be able to be published through the traefik load balancer we will need to attached them also to this network.

>One container can be attached to severals differents networks

Traefik also have a Web UI which has been deployed on port 8080 : https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

> In production you'll need to ensure the UI is only private & secure

## Try it!

With the Traefik load balancer configured to listen and proxy traffic to containers, based on thecontainers's metadatas, we need to configure thoses metadata as docker labels:

### route With Path

<pre class="file" data-filename="docker-compose-test.yml" data-target="replace">
version: "2"

services:
  test:
    image: nginx
	expose: 
	  - 80
    labels:
      - "traefik.frontend.rule=Path:/test"
	  - "traefik.docker.network=traefik_net"				
    networks:
	  - traefik_net
networks:
  traefik_net:
    external: true
</pre>

launch the container `docker-compose -p test -f docker-compose-test.yml up -d`{{execute}}

We have attached the test container on the network traefik_net. You can see that on this network we have now 2 containers connects : `docker network inspect traefik_net`{{execute}}`


### route With Host

<pre class="file" data-filename="docker-compose-test2.yml" data-target="replace">
version: "2"

services:
  test2:
    image: nginx
	expose: 
	  - 80
    labels:
      - "traefik.frontend.rule=Host:[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com"
	  - "traefik.docker.network=traefik_net"				
    networks:
	  - traefik_net
networks:
  traefik_net:
    external: true
</pre>

execute `docker-compose -p test2 -f docker-compose-test2.yml up -d`{{execute}}


### Define a proxification labels example.

Launch the LoadBalancer

`docker-compose up -d`{{execute}}


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
