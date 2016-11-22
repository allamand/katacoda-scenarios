
> You can click directly to Continue if you want to skip failure node simulation



### Task: Simulate Outage

We can simulate a network outage or machine failure, via killing an agent `docker kill c3`{{execute}}.

After a couple of seconds, the heartbeat and health check will fail. The state of the member will change from active to failed.

`docker exec -t c1 consul members`{{execute}}

If this node was elected the leader then another election would have taken place. This can be viewed in the logs `docker logs c1`{{execute}}

### Task : Restoring 3 nodes


we restore the C3 node

`docker start c3`{{execute}}

check that it cames back to life : `docker exec -t c1 consul members`{{execute}}
