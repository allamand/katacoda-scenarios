
## Add Services and plug them with the Traefik Load Balancer

With the **Traefik** load balancer configured to route traffic to containers using **docker events** information, based on thecontainers's metadatas, we need to configure thoses metadata as docker labels:

### Configure service with routing based on URL Path

We can set a label telling traefik to route the traffic according to the target service URI Path using **traefik.frontend.rule** label:

<pre class="file" data-filename="docker-compose-test.yml" data-target="replace">
version: "2"

services:
  test:
    image: nginx
	expose: 
	  - 80
    labels:
      - "traefik.backend=test"
      - "traefik.port=80"
	  - "traefik.frontend.rule=PathPrefixStrip:/route1/"
	  - "traefik.docker.network=traefik_net"				
    networks:
	  - traefik_net
networks:
  traefik_net:
    external: true
</pre>

#### launch the container

`docker-compose -p test -f docker-compose-test.yml up -d`{{execute}}

We have attached the test container on the network **traefik_net**. we have now 2 containers connected to that network we can inspect with : `docker network inspect traefik_net`{{execute}}`


>Check the [Traefik Dashboard](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com) and you will see that a new Entry was added. 

If we request the Proxy with the **/route1/** path `curl http://docker/route1/`{{execute}} we can see in response that it is the test container that make the response

You can Request the service directly expose on : https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/route1/


You can request the logs of the Traefik Load Balancer:  `docker logs traefik_traefik_1`{{execute}}

You can request the logs of the application `docker-compose -p test -f docker-compose-test.yml logs`{{execute}}




## Scaling Service

We can use docker-compose to scale some services of our applications: Exemple, scale 5 instances of the test service:


You can make local calls to the test service and see the loadbalancing :`curl -H "Host: [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com" http://docker/`{{execute}}


You can see that test service has several backend configured in the Traefik UI :

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

You can see logs of your tests on Traefik `docker logs traefik_traefik_1`{{execute}}



# Task: routing based on Host Header

we just saw how we can use Traefik to leverage **Path** based routing mechanisms.

Try no to uses traefik with a **Host** based routing mechanism (routing based on the requested Domain Name)...



