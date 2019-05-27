git clone https://github.com/Orange-OpenSource/cassandra-k8s-operator.git
helm init
sleep 10
kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-
