#swith user to CassKop directory
#cd cassandra-k8s-operator


git clone https://github.com/Orange-OpenSource/cassandra-k8s-operator.git
helm init

# Configure local storate
#echo "Install Rancher local--path-provisioner"
#mkdir -p /opt/local-path-provisioner
#ssh node01 "mkdir -p /opt/local-path-provisioner"
#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
#kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

cd cassandra-k8s-operator
git checkout pipeline

echo "Install local-provisioner"
kubectl create namespace local-provisioner
kubectl config set-context $(kubectl config current-context) --namespace=local-provisioner
tools/configure-katacoda-local-storage.sh create
k apply -f tools/local-provisioner.yaml



kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-

kubectl config set-context $(kubectl config current-context) --namespace=default

