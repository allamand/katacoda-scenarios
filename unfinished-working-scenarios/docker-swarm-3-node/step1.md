When the manager initialises the cluster, it generates a token. This token must be used when additional hosts want to join.
Task

Initialise the cluster using `docker swarm init`{{execute}}

In the next step, we will use the token so our second host can join.


## checking environment

You can now `docker info`{{execute}}
