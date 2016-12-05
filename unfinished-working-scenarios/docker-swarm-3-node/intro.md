This scenario covers how to securely manage new nodes joining a Swarm Mode cluster. The scenario covers how to define a password for joining along with manually accepting nodes into the cluster.

By default, anyone who can communicate with a Swarm Master via port 2377 can join the cluster. This port should be locked down and restricted to only trusted machines.

On a large network with additional security requirements, companies might want to add additional security to ensure that only verified nodes are allowed.
