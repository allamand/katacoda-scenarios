

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

With the following file, CassKop will start a 1 node Cassandra Cluster in 1 dc/rack

`kubectl apply -f ~/cassandracluster-katacoda.yaml`{{execute}}

you can see the pod creation 

`kubectl get pods -o wide`{{execute}}

> It may take near 1-2 minutes for each Cassandra pod to boot

you can see the log of the new Cassandra pod starting:

`kubectl logs  cassandra-demo-dc1-rack1-0`{{execute}}

You can follow the logs of CassKop 

`kubectl logs -f $(kubectl get pods -l app=cassandra-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}')`{{execute}}

> Ctrl-C to exit


## Get CassKop status

CassKop will update the status section in the CassandCluster object.

Once the Cassandre nodes are up the status must be **Done**

`kubectl describe cassandracluster`{{execute}}
```
Status:
  Cassandra Rack Status:
    Dc 1 - Rack 1:
      Cassandra Last Action:
        Name:        UpdateStatefulSet
        End Time:    2019-05-27T12:56:13Z
        Start Time:  2019-05-27T12:55:48Z
        Status:      Done
      Phase:         Running
      Pod Last Operation:
  Last Cluster Action:         Initializing
  Last Cluster Action Status:  Done
  Phase:                       Running
  Seedlist:
    cassandra-demo-dc1-rack1-0.cassandra-demo-dc1-rack1.default
```

In this example, We have deployed 1 Cassandra Pod in dc1 for rack1. 
Casskop return status for each Rack (just one in this case) and a global state **Last Cluster Action Status**

By default, CassKop manage the cluster seed list with 3 seeds per datacenters.

We check that Cassandra node is up and running:

`kubectl exec -ti cassandra-demo-dc1-rack1-0 nodetool status`{{execute}}
```
Datacenter: dc1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.40.0.4  113.73 KiB  256          100.0%            67b0c912-63af-4953-8e5f-f1c1e2badb4b  rack1
```

> we have only 1 node in rack1 from dc1

## Troubleshooting

If something get wrong, we can check kubernetes events

`kubectl get events -w --sort-by .metadata.creationTimestamp`{{execute}}


