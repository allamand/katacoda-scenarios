# Configure the Cluster

## Check configuration

You should have 2 node kubernetes cluster (master and node0)

`k get nodes`{{execute}}
```
```

> If you don't see 2 kubernetes nodes or if the directory cassandra-k8s-operator is missing, please redresh the page
> while something in the init may have gone wrong..


## Check installation of local-provisioner for local storage

Wait for all pods to be running

`k get pods --all-namespaces`{{execute}}


## No persistent volume

For the sake of simplicity I will launch the Cassandra without persistent volume to back the data. This is not 
to replicate in real environment, but it will ease the time to set-up this hand-on.

CassKop will warn you in it's log with messages like 

```
level=warning msg="[cassandra-demo]: No Spec.DataCapacity was specified -> You Cluster WILL NOT HAVE PERSISTENT
DATA!!!!!"
```

<!--
## Check that the persistent volumes are created

`k get pv`{{execute}}
```
NAME                CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS    REASON    AGE
local-pv-12f93e0a   1951Mi     RWO            Delete           Available             local-storage             2m
local-pv-2018d83c   1951Mi     RWO            Delete           Available             local-storage             2m
local-pv-32a48e67   1951Mi     RWO            Delete           Available             local-storage             2m
local-pv-3bea2b09   1000Mi     RWO            Delete           Available             local-storage             2m
local-pv-6585b3a0   1000Mi     RWO            Delete           Available             local-storage             2m
local-pv-69823ebf   1000Mi     RWO            Delete           Available             local-storage             2m
local-pv-de1034d    1951Mi     RWO            Delete           Available             local-storage             2m
local-pv-e7f6fbc3   1000Mi     RWO            Delete           Available             local-storage             2m
local-pv-f30b01a6   1000Mi     RWO            Delete           Available             local-storage             2m
local-pv-f37d14f0   1951Mi     RWO            Delete           Available             local-storage             2m
```
-->
## Troubleshooting

If needed you can check for events on the cluster: 

`kubectl get events --sort-by .metadata.creationTimestamp --all-namespaces`{{execute}}
