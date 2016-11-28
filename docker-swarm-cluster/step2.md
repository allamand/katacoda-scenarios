## Add Additional Consul Agents

Once the agent has started, we can tell other agents to join the newly created cluster. Agents register using the provided the IP address of how to communicate with another Consul agent.

### Task: Add two additional Consul agents

We can use Docker to obtain the IP address of the first container we started. We also output the IP address of the container to the terminal, it should be in the 172.18.0.0 range.

`IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' c1); echo $IP`{{execute}}

When we launch our two additional agents we tell them how to locate the cluster.

`docker run -d --name c2 consul agent -dev -bind=0.0.0.0 -join=$IP`{{execute}}

`docker run -d --name c3 consul agent -dev -bind=0.0.0.0 -join=$IP`{{execute}}

We will now have a Consul cluster running on our Docker daemon. You can see the communications and events via the logs `docker logs c1`{{execute}}

In the next step we explore what happens if nodes fail.
