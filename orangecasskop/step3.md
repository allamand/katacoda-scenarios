

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

`k apply -f ~/cassandracluster-katacoda.yaml`{{execute}}

you can see the pod creation 

`k get pods -o wide`{{execute}}

> It may take near 1-2 minutes for each Cassandra pod to boot

you can see the log of the new Cassandra pod starting:

`k logs  cassandra-demo-dc1-rack1-0`{{execute}}

and for second pod:

`k logs  cassandra-demo-dc1-rack2-0`{{execute}}

You can follow the logs of CassKop 

`k logs -f $(k get pods -l app=cassandra-k8s-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}')`{{execute}}

> Ctrl-C to exit


## Get CassKop status

CassKop will update the status section in the CassandCluster object.

Once the Cassandre nodes are up the status must be **Done**

`k describe cassandracluster`{{execute}}
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
    Dc 1 - Rack 2:
      Cassandra Last Action:
        Name:      Initializing
        End Time:  2019-05-27T12:58:01Z
        Status:    Done
      Phase:       Running
      Pod Last Operation:
    Dc 1 - Rack 3:
      Cassandra Last Action:
        Name:      Initializing
        End Time:  2019-05-27T12:59:59Z
        Status:    Done
      Phase:       Running
      Pod Last Operation:
  Last Cluster Action:         Initializing
  Last Cluster Action Status:  Done
  Phase:                       Running
  Seedlist:
    cassandra-demo-dc1-rack1-0.cassandra-demo-dc1-rack1.default
    cassandra-demo-dc1-rack2-0.cassandra-demo-dc1-rack2.default
```

In this example, We have deployed 3 Racks so we have 3 different status, one for each racks,
anbd a global state **Last Cluster Action Status**

By default, CassKop manage the cluster seed list with 3 seeds per datacenters.

## Troubleshooting

If something get wrong, we can check kubernetes events

`make events`{{execute}}


