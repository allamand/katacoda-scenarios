

We Have see how we can leverage Docker labels to dynamically customize our LoadBalancing routing rules, and docker-compose to create and links services together.

Now let's try to launch a **more complicated** Microservice application.

We will uses the docker's vote microservice application with custom labels to be used within our traefik loadbalancer.

<img src="https://github.com/allamand/example-voting-app/raw/master/architecture.png" width="600">

Which is composed of :
- A Python webapp which lets you vote between two options
- A Redis queue which collects new votes
- A Java worker which consumes votes and stores them in…
- A Postgres database backed by a Docker volume
- A Node.js webapp which shows the results of the voting in real time
 					

## Run voting microservice application

First you need to Retrieve voting-app application 

`git clone https://github.com/allamand/example-voting-app.git`{{execute}}

Go to the stack directory 

`cd example-voting-app`{{execute}} 

and launch the app using docker-compose 

`time docker-compose -f docker-compose-katacoda.yml up -d`{{execute}}.

> This command will build each part of the microservice from sources.
> You can take a coffee since this may take a little to finish (not too long so that the interface don't go in timeout)

When Finished, you can view the status of your deployment using 
`docker-compose -f docker-compose-katacoda.yml ps`{{execute}}

>If not all services are up on the previous command, you can try again to **up** them again - this can be due to the fact that the worker spin up faster than the DB, and it break if the db is not there (the worker don't respect correctly the [12 Factors](https://12factor.net) principles.
`docker-compose -f docker-compose-katacoda.yml up -d`{{execute}}.

Check the [Traefik Dashboard](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com) and you will see that a 2 new entries was added (frontend-PathPrefixStrip-result & frontend-PathPrefixStrip-vote)


Normally you can now test the 2 endpoints of the voting application :

* [Vote](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/vote/) - to make you vote / you can change your mind
* [Result](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/result/) - to visualize the result of all votes

you can see the logs of the services :
`docker-compose -f docker-compose-katacoda.yml logs`{{execute}}.

> `Ctrl-C` in console to exit docker-compose logs command

You are now able to deploy any stack on Docker Swarm using docker-compose and Traefik Proxy!

