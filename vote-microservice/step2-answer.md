



### routing based on HOST Header

We can set a label telling traefik to route the traffic according to the value of the incomming HTTP Request **Host** header **traefik.frontend.rule** label:

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

#### Launch the service

`docker-compose -p test2 -f docker-compose-test2.yml up -d`{{execute}}


We have attached the test2 container on the network **traefik_net**. we have now 3 containers connected to that network we can inspect with : `docker network inspect traefik_net`{{execute}}`


>Check the Traefik Dashboard and you will see that a new Entry was added https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

You should be able to reach your nginx at the Url defined in the compose file :

https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com

>Note: In the Katacoda context, there is already a complicated routing mechanism that allows you to reach your test environnement. This is configure using **$HOST_SUBDOMAIN** and **$KATACODA_HOST** Variables which we reuse in the docker traefik label.


If we request the Proxy with the specific **Host** header `curl -H "Host: [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com" http://docker/`{{execute}} we can see in response that it is the nginx that make the response

We can check logs on traefik `docker logs traefik_traefik_1`{{execute}}

