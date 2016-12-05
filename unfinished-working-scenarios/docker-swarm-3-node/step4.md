With Docker 1.12 you have now new possibility to deploy & manage applications.
This is called the service model:

By default, Docker uses a spread replication model for deciding which containers should run on which hosts. The spread approach ensures that containers are deployed across the cluster evenly. When one of the nodes are removed from the cluster, the containers running are spread across the other nodes available.

A new concept of Services is used to run containers across the cluster. This is a higher-level concept than containers. A service allows you to define how applications should be deployed at scale. By updating the service, Docker updates the container required in a managed way.

## Task

In this case, we are deploying the Docker Image katacoda/docker-http-server. We are defining a friendly name of a service called http and that it should be attached to the newly created skynet network.

For ensuring replication and availability, we are running two instances, of replicas, of the container across our cluster.

Finally, we load balance these two containers together on port 80. Sending an HTTP request to any of the nodes in the cluster will process the request by one of the containers within the cluster.

The node which accepted the request might not be the node where the container responses. Instead, Docker load-balances requests across all available containers. (Thanks to it's internal routing mesh)

`docker service create --name http --network skynet --replicas 2 -p 80:80 katacoda/docker-http-server`{{execute}}

You can view the services running on the cluster using the CLI command `docker service ls`{{execute}}

As containers are started you will see them using the `docker ps`{{execute}} command. You should see one instance of the container on each host.

List containers on the first host - `docker ps`{{execute-1}}

List containers on the second host - `docker ps`{{execute-2}

If we issue an HTTP request to the public port, it will be processed by the two containers `curl docker``{{execute}}.

