# CassKop's CRD: cassandracluster

CassKop define its own Custom Ressource Definition named **cassandracluster**
This new k8s objects allow to describe the Cassandra cluster a user wants to manage.
We can interract directly with this new objects using kubectl.


## Configuration

In this course we have installed [Rancher local path provisioner](https://github.com/rancher/local-path-provisioner) to
let CassKop retrieve local volume dynamically.


We have a very small 2 nodes kubernetes cluster with 1 master and 1 node, and we have untaint the master so that it can
get some pod sheduled.
