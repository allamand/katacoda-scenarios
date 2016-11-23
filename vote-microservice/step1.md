

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

This allow to use a docker network to plug the container on.

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

You can see the logs of your application using docker-compose `docker-compose -p traefik logs`{{execute}}
or using docker `docker logs traefik_traefik_1`{{execute}}


## Add Services and plug them with the Traefik Load Balancer

With the Traefik load balancer configured to listen and proxy traffic to containers, based on thecontainers's metadatas, we need to configure thoses metadata as docker labels:

### routing based on URL Path

<pre class="file" data-filename="docker-compose-test.yml" data-target="replace">
version: "2"

services:
  test:
    image: katacoda/docker-http-server
	expose: 
	  - 80
    labels:
      - "traefik.backend=test"
      - "traefik.port=80"
	  - "traefik.frontend.rule=Path:/route1/"
	  - "traefik.docker.network=traefik_net"				
    networks:
	  - traefik_net
networks:
  traefik_net:
    external: true
</pre>

launch the container `docker-compose -p test -f docker-compose-test.yml up -d`{{execute}}

We have attached the test container on the network **traefik_net**. we have now 2 containers connected to that network we can inspect with : `docker network inspect traefik_net`{{execute}}`


>Check the Traefik Dashboard and you will see that a new Entry was added. https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

If we request the Proxy with the **/route1/** path `curl http://docker/route1/index.html`{{execute}} we can see in response that it is the test container that make the response

You can Request the service from : https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/route1/


You can request the logs of the Traefik Load Balancer:  `docker logs traefik_traefik_1`{{execute}}



### routing based on HOST Header

This is the default routing mode of Traefik

<pre class="file" data-filename="docker-compose-test2.yml" data-target="replace">
version: "2"

services:
  test2:
    image: katacoda/docker-http-server:v2
	expose: 
	  - 80
    labels:
      - "traefik.backend=test2"
      - "traefik.port=80"
      - "traefik.frontend.rule=Host:${HOST_SUBDOMAIN}-80-${KATACODA_HOST}.environments.katacoda.com"
	  - "traefik.docker.network=traefik_net"				
    networks:
	  - traefik_net
networks:
  traefik_net:
    external: true
</pre>

execute `docker-compose -p test2 -f docker-compose-test2.yml up -d`{{execute}}


We have attached the test2 container on the network **traefik_net**. we have now 3 containers connected to that network we can inspect with : `docker network inspect traefik_net`{{execute}}`


>Check the Traefik Dashboard and you will see that a new Entry was added https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

You should be able to reach your nginx at the Url defined in the compose file :

https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com

>Note: In the Katacoda context, there is already a complicated routing mechanism that allows you to reach your test environnement. This is configure using **$HOST_SUBDOMAIN** and **$KATACODA_HOST** Variables which we reuse in the docker traefik label.


If we request the Proxy with the specific **Host** header `curl -H "Host: [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com" http://docker/`{{execute}} we can see in response that it is the nginx that make the response

We can check logs on traefik `docker logs traefik_traefik_1`{{execute}}


# Task: Scaling service

Please Try now to scale service test2 to see how it is handle by the Traefik load balancer


