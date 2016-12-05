With the cluster requiring a token, it must be specified when a host wants to join the cluster.

## Example

If an attempt to join the cluster without a token is made then it will return an error.

`docker swarm join 172.17.0.62:2377`{{execute}}
TODO: does the IP is ok ?

Likewise, if you attempt an incorrect password it will error.

`docker swarm join 172.17.0.62:2377 --token test`

The only way to join is if the node knows the correct password for the cluster. For demonstration purposes, we'll ask the manager what the token is via swarm join-token. In production, this token should be stored securely and only accessible by trusted individuals.

`token=$(docker -H 172.17.0.62:2345 swarm join-token -q worker) && echo $token`{{execute}}

`docker swarm join 172.17.0.62:2377 --token $token`{{execute-2}}

Afterwards, it will be added as expected `docker node ls`{{execute}}

