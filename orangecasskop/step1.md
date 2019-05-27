# Configure the Cluster

## Check configuration

You should have 2 node kubernetes cluster (master and node0)

`k get nodes`{{execute}}


## Install local-provisioner for local storage

`kubectl create namespace local-provisioner
kubectl config set-context $(kubectl config current-context) --namespace=local-provisioner
KUBE_NODES=$(kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{" "}')
NB_PV=5

kubectl apply -f tools/storageclass-local-storage.yaml

for n in $KUBE_NODES; do
    echo $n
    for i in `seq -w 1 $NB_PV`; do
        ssh -f -q -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $n "mkdir -p /dind/local-storage/pv$i"
        ssh -f -q -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $n "mount -t tmpfs pv$i /dind/local-storage/pv$i"
    done
done
k apply -f tools/local-provisioner.yaml
kubectl config set-context $(kubectl config current-context) --namespace=default`{{execute}}




## Troubleshooting

If needed you can check for events on the cluster: 

`kubectl get events --sort-by .metadata.creationTimestamp --all-namespaces`{{execute}}
