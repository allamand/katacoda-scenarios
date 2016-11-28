This is your first step.

## Start Consul Agent

This is an _example_ of creating a scenario and running a **command**


To start, we'll launch a primary Consul agent which others will connect too. Each of these agents will run as separate containers on the same node. In production, each of the containers would run on different machines.

The agents will form the initial cluster and Consul Quorum for ensuring data stored is consistent and remains available after outages.

### Task: Launch Agent

To start an launch we use the official Docker image and provide the arguments agent -dev. To make the UI accessible we tell Consul to bind to the public IP instead of 127.0.0.1. The UI runs on port 8500 which we map to the host.

`docker run -d --name=c1 -p 8500:8500 consul agent -dev -client=0.0.0.0 -bind=0.0.0.0`{{execute}}

Because we haven't told this agent to join a cluster, it will create one for us. In the next step we'll add additional agents.

