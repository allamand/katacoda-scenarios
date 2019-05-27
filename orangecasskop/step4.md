

# ScaleUp the cluster

Now we request CassKop to have 2 nodes per each rack, which will add 2 additioanl Cassandra nodes.

`kubectl patch cassandracluster cassandra-demo -p '{"spec":{"topology": {"dc": [{"name": "dc1","nodesPerRacks":2,"rack": [{"name": "rack1"},{"name": "rack2"}]}]}}}' --type merge

We can see the pods creation: 

`k get pods -o wide`{{execute}}

You can follow the logs of CassKop 

`k logs $(k get pods -l app=cassandra-k8s-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}') -f`{{execute}}

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
        Name:        ScaleUp
        Start Time:  2019-05-27T15:11:54Z
        Status:      Ongoing
      Phase:         Pending
      Pod Last Operation:
    Dc 1 - Rack 2:
      Cassandra Last Action:
        Name:      Initializing
        End Time:  2019-05-27T15:01:38Z
        Status:    Done
      Phase:       Running
      Pod Last Operation:
  Last Cluster Action:         ScaleUp
  Last Cluster Action Status:  Ongoing
  Phase:                       Pending
  Seedlist:
    cassandra-demo-dc1-rack1-0.cassandra-demo-dc1-rack1.default
    cassandra-demo-dc1-rack2-0.cassandra-demo-dc1-rack2.default
```

## Data cleanup the cluster 

When the ScaleUp is Done :

```
  Last Cluster Action:         ScaleUp
  Last Cluster Action Status:  Done
```

we can do a data cleanup using the CassKop plugin:


