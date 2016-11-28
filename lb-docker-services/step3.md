

We Have see how we can leverage Docker labels to dynamically customize our LoadBalancing routing rules.

Now let's try to launch a **more complicated** Microservice application.

We will uses the docker's vote microservice application with custom labels to be used within our traefik loadbalancer.

## Example voting microservice application

First you need to Retrieve voting-app application 

`git clone https://github.com/allamand/example-voting-app.git`{{execute}}

Go to the stack directory 

`cd example-voting-app`{{execute}} 

and launch the app using docker-compose 

`docker-compose -f docker-compose-katacoda.yml up -d`{{execute}}.

> You can take a coffee since this may take a little to finish : It will build each part of the microservice app (node.js, npm, dot.net, redis, postgresql)

You can view the status of your deployment using 
`docker-compose -f docker-compose-katacoda.yml ps`{{execute}}

>If not all services are up on the previous command, you can try again to up them - this can be due to the fact that the worker spin up faster than the DB, and it break if the db is not there (the worker d'ont respect correctly the [12 Factors](https://12factor.net)
`docker-compose -f docker-compose-katacoda.yml up -d`{{execute}}.

>Check the [Traefik Dashboard](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com) and you will see that a new Entry was added. 


Normally you can now test the 2 endpoints of the voting application :

- [Vote](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/vote/)
- [Result](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/result/)

you can see the logs of the services :
`docker-compose -f docker-compose-katacoda.yml logs`{{execute}}.


You are now able to deploy any stack on Docker Swarm using docker-compose and Traefik Proxy!

