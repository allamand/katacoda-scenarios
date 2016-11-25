

# Scaling Service

To scale the service you need to type :

`docker-compose -p test2 -f docker-compose-test2.yml scale test2=5`{{execute}}

test locally :`curl -H "Host: [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com" http://docker/`{{execute}}

test from browser : https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com

You can see that test2 service has several backend configured in the Traefik UI :

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

You can see logs on Traefik `docker logs traefik_traefik_1`{{execute}}
