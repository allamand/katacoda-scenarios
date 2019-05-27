#swith user to CassKop directory
cd cassandra-k8s-operator




# Configure local storate
#echo "Install Rancher local--path-provisioner"
#mkdir -p /opt/local-path-provisioner
#ssh node01 "mkdir -p /opt/local-path-provisioner"
#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
#kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


#echo "Install local-provisioner"
kubectl create namespace local-provisioner
#kubectl config set-context $(kubectl config current-context) --namespace=local-provisioner
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


#kubectl patch storageclass local-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-


#kubectl config set-context $(kubectl config current-context) --namespace=default

#kubectl patch cassandracluster cassandra-demo --type json -p '{"spec":{"topology": { "dc": [{"name": "dc1", "nodesPerRacks": "2"}] } } }'
