#swith user to CassKop directory
sleep 3
cd cassandra-k8s-operator




# Configure local storate
#echo "Install Rancher local--path-provisioner"
#mkdir -p /opt/local-path-provisioner
#ssh node01 "mkdir -p /opt/local-path-provisioner"
#ssh -f -q -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null master "mkdir -p /opt/local-path-provisioner"
#ssh -f -q -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null node01 "mkdir -p /opt/local-path-provisioner"
#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
#kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


#echo "Install local-provisioner"
kubectl create namespace local-provisioner
KUBE_NODES=$(kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{" "}')
for n in $KUBE_NODES; do
    echo $n
    for i in `seq -w 1 5`; do
        ssh -f -q -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $n "mkdir -p /dind/local-storage/pv$i"
        ssh -f -q -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $n "mount -t tmpfs pv$i /dind/local-storage/pv$i"
    done
done
k apply -f tools/storageclass-local-storage.yaml
k apply -f tools/local-provisioner.yaml

#kubectl patch cassandracluster cassandra-demo --type json -p '{"spec":{"topology": { "dc": [{"name": "dc1", "nodesPerRacks": "2"}] } } }'

#kubectl patch cassandracluster cassandra-demo --dry-run -p '{"spec":{"topology": { "dc": [{"name": "dc1", "nodesPerRacks": "2"}] } } }' --type merge

kubectl patch cassandracluster cassandra-demo -p '{"spec":{"topology": { "dc": [{"name": "dc1", "nodesPerRacks": "2"}, "rack": [{"name": "rack1"}],[{"name": "rack2"}] } } }' --type merge --dry-run -o yaml

