git clone https://github.com/Orange-OpenSource/cassandra-k8s-operator.git
helm init

mkdir -p /opt/local-path-provisioner
ssh node01 "mkdir -p /opt/local-path-provisioner"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-
