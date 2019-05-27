

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

With the following file, CassKop will start a 2 node Cassandra Cluster

`k apply -f samples/cassandracluster.yaml`{{execute}}

you can see the pod creation 

`k get pods`{{execute}}


you can see the log of the new Cassandra pod starting :

`k logs  cassandra-demo-dc1-rack1-0`{{execute}}



You can follow the logs of CassKop 

`k logs -f $(k get pods -l app=cassandra-k8s-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}')`{{execute}}

> Ctrl-C to exit


## Troubleshooting

If something get wrong, we can check kubernetes events

`make events`{{execute}}


