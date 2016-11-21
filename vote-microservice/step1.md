

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
{{execute}}

The Load Balancer is configured to listen on port 80,443 HTTP traefik, and also procide a web dashboard that is exposed on port 8080.

The use of docker.sok allows traefik to listen to the Docker Host Daemon events, and reconfigure itself when containers are started/stopped. 
>To work with a swarm cluster with TLS security layer, the configuration to launch the Traefik container will be sifferent.


## Define service container

With the Traefik load balancer configured to listen and proxy traffic to containers, based on thecontainers's metadatas, we need to configure thoses metadata as docker labels:

### Define a proxification labels example.

Launch the LoadBalancer

`docker-compose up -d`{{execute}}

you can access the dashboard using :
http://[[CLIENT_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com



## Install Docker compose

`curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > ./docker-compose`{{execute}}

`chmod +x ./docker-compose && sudo mv ./docker-compose /usr/local/bin/docker-compose`{{execute}}


## Install Docker 1.12

`sudo apt-get update`{{€xecute}} et `sudo apt-get install -y docker-engine`{{execute}}.
Check that install is ok `docker -v`{{execute}}

## Clone the vote microservice stack

`git clone https://github.com/philipz/example-voting-app`{{execute}}

git clone https://github.com/bfirsh/serverless-docker-voting-app

