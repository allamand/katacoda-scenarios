
Before starting the lab, let's check pre-requisites are OK

## Check you get the code

On the terminal, you must see the content listing of the CassKop GitHub repository

## Check configuration

You should have 2 node kubernetes cluster (master and node0)

`k get nodes`{{execute}}
```
NAME      STATUS    ROLES     AGE       VERSION
master    Ready     master    1h        v1.11.3
node01    Ready     <none>    1h        v1.11.3
```

> If you don't see 2 kubernetes nodes or if the directory cassandra-k8s-operator is missing,
> try to `launch.sh`{{execute}} to restart kubernetes and wait a little more..
>
> If it does not works, please refresh the page
> while something in the init may have gone wrong..


## Check all pods are running


`k get pods --all-namespaces`{{execute}}



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
