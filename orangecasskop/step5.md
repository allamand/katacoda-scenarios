

# ScaleDown the cluster

Now we request CassKop to have again only 1 nodes per each rack, which will remove 1 Cassandra nodes.

`kubectl patch cassandracluster cassandra-demo -p '{"spec":{"topology": {"dc": [{"name": "dc1","nodesPerRacks":1,"rack": [{"name": "rack1"}]}]}}}' --type merge`{{execute}}`

We can see the pods creation: 

`k get pods -o wide`{{execute}}

You can follow the logs of CassKop 

`k logs $(k get pods -l app=cassandra-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}') -f`{{execute}}

> Ctrl-C to exit


## Get CassKop status

CassKop will update the status section in the CassandCluster object.

Once the Cassandra nodes are up the status must be **Done**

`k describe cassandracluster`{{execute}}
```
Status:
  Cassandra Rack Status:
    Dc 1 - Rack 1:
      Cassandra Last Action:
        Name:        ScaleDown
        Start Time:  2019-05-27T15:11:54Z
        Status:      Ongoing
      Phase:         Pending
      Pod Last Operation:
  Last Cluster Action:         ScaleDown
  Last Cluster Action Status:  Ongoing
  Phase:                       Pending
  Seedlist:
    cassandra-demo-dc1-rack1-0.cassandra-demo-dc1-rack1.default
```

CassKop will make a Cassandra decommission priori to remove the Pod at Kubernetes level.

## Following

You can tests more scenarios folloging our [demo
slides](https://orange-opensource.github.io/cassandra-k8s-operator/slides/index.html?slides=Slides-CassKop-demo.md) 

and give us your feedbacks via :
- [our mailing list](mailto:prj.casskop.support@list.orangeportails.net)
- https://casskop.slack.com

Project source on Orange [GitHub](https://github.com/Orange-OpenSource/cassandra-k8s-operator)
