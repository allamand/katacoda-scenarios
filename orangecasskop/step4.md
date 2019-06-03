

# ScaleUp the cluster

Now we request CassKop to scale nodes number in the rack

`kubectl patch cassandracluster cassandra-demo -p '{"spec":{"topology": {"dc": [{"name": "dc1","nodesPerRacks":2,"rack": [{"name": "rack1"}]}]}}}' --type merge`{{execute}}

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


`kubectl casskop cleanup --prefix cassandra-demo-dc1`{{execute}}


We can see that the status of cassandra-demo CassandraCluster object will reflect the operation status of each pods.

CassKop will also updates labels on each pods we can see that with :

`for x in `seq 1 2`; do
 echo cassandra-demo-dc1-rack$x;
 kubectl label pod cassandra-demo-dc1-rack$x-0 --list | grep operation ; echo ""
 kubectl label pod cassandra-demo-dc1-rack$x-1 --list | grep operation ; echo ""
done`{{execute}}
