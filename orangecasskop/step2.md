

# Deployment of a Cassandra cluster 

Casskop work by default with it's custom [Cassandra image](https://github.com/Orange-OpenSource/cassandra-image) which
can be customize with ConfigMap

## Create our Cassandra configuration

`kubectl apply -f samples/cassandra-configmap-v1.yaml`{{execute}}


Normally CassKop can be configure to spread it's node with a dc/rack aware topology configuration where we uses
kubernetes nodes labels to associated Cassandra's dc/rack spreading mode.

With this Katacoda example, there is no enough nodes, so we are not going to uses labels, but you can find others
examples with labels in the sample directory.

## Deploy our Cassandra cluster demo

`k apply -f samples/cassandracluster.yaml`
