

We Have see how we can leverage Docker labels to dynamically customize our LoadBalancing routing rules.

Now let's try to launch a more complicated Microservice application.

We will uses the docker's vote microservice application with custom labels to be used within our traefik loadbalancer.

## Example voting microservice application

First you need to Retrieve voting-app application 

`git clone https://github.com/allamand/example-voting-app.git`{{execute}}

Go to the stack directory 

`cd example-voting-app`{{execute}} 

and launch the app using docker-compose 

`docker-compose -d docker-compose-katacoda.yml up -d`{{execute}}.

> You can take a coffee since this may take a little to finish : It will build each part of the microservice app (node.js, npm, dot.net, redis, postgresql)

You can view the status of your deployment using `docker-compose ps`{{execute}}

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

