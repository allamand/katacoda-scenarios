
## Simulate a Node Failure

We can list all the members of a Consul cluster by asking one of our Containers `docker exec -t c1 consul members`{{execute}}

### Task: Simulate Outage

We can simulate a network outage or machine failure, via killing an agent `docker kill c3`{{execute}}.

After a couple of seconds, the heartbeat and health check will fail. The state of the member will change from active to failed.

`docker exec -t c1 consul members`{{execute}}

If this node was elected the leader then another election would have taken place. This can be viewed in the logs `docker logs c1`
