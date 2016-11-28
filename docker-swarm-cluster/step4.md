
## Consul UI

Along with the CLI, you can see the state of the cluster via the UI. It is accessible on port 8500 via this link 
- https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui/


The Services tab list provides a catalog of services registered with Consul. A service can be running on multiple nodes. In this case, Consul would be the server running on two ones, with one failed node. Services could be web applications, databases, brokers, etc that other applications need to discover to communicate with.

The Nodes tab lists all nodes where Services are running. If any Nodes have previously failed they'll be listed here along with health check was the reason it was marked unhealthy. This gives you an overview of your cluster state.

## Going back with 3 instances consul cluster

`docker rm c3 && docker run -d --name c3 consul agent -dev -bind=0.0.0.0 -join=$IP`{{execute}}

Verify that all instances are up & running :
`docker exec -t c1 consul members`{{execute}}

You now have a Consul cluster running as Docker containers.

Let's find in new course what we can do with it
