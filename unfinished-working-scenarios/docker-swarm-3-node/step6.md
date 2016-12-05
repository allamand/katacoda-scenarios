A Service allows us to scale how many instances of a task is running across the cluster. As it understands how to launch containers and which containers are running, it can easily start, or remove, containers as required. At the moment the scaling is manual. However, the API could be hooked up to an external system such as a metrics dashboard.

## Task

At present, we have two load-balanced containers running, which are processing our requests `curl docker`{{execute}}

The command below will scale our http service to be running across five containers.

`docker service scale http=5`{{execute}}

On each host, you will see additional nodes being started `docker ps`{{execute}}

The load balancer will automatically be updated. Requests will now be processed across the new containers. Try issuing more commands via `curl docker`{{execute}}

Try scaling the service down to see the result

