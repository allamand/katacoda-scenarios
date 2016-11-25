


In this advance scenario we need to set-up a LoadBalancer Named **Traefik**, which will uses Docker **Events** informations to dynamically set-up LoadBalancing Rules according do Docker Labels define at Containers Launch (start/stop..)

It is using docker container labels to define the metadata and rules for dynamically configure routing rules from traefik to real applications (on whichever Host they are within a Docker Swarm Cluster).

>To make it simpler for this demo we will only be using 1 docker Host instad of a swarm cluster

### Create Traefik LoadBalancer Docker Container

We start creating the Docker Compose file docker-compose.yml by first defining the service name, which docker command to uses to launch it, and which ports will be exposed on the Host :

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


Now we add Traefik Label & Network definitions:

<pre class="file" data-filename="docker-compose.yml" data-target="append">
    labels:
      - "traefik.enable=false"
    networks:
	  - net

networks:
  net:
</pre>

This allow to use a docker network to plug the container on. and disable proxification for the service

## Launch the LoadBalancer Docker Container

`docker-compose -p traefik up -d`{{execute}}

The Load Balancer is configured to listen on port 80,443 HTTP traefik, and also provide a web dashboard that is exposed on port 8080.

The use of docker socket allows traefik to listen to the Docker Host Daemon events, and reconfigure itself when containers are started/stopped. 
>To work with a swarm cluster with TLS security layer, the configuration to launch the Traefik container will be different.

Check docker networks `docker network ls`{{execute}}. You can see that a specific network **traefik_net** has been created.

Later If we want others containers to be able to be published through the traefik load balancer we will need to **attached them** also to this network.

>One container can be attached to severals differents networks

### See LoadBalancer Logs

You can see the logs of your application using docker-compose `docker-compose -p traefik logs`{{execute}}
or using docker `docker logs traefik_traefik_1`{{execute}}

### See LoadBalancer Dashboard

Traefik also have a Web UI which has been deployed on port 8080 : https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

> In production you'll need to ensure the UI is only private & secure


