git clone https://github.com/Orange-OpenSource/cassandra-k8s-operator.git

curl -LO -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.13.3/bin/linux/amd64/kubectl

curl -L -O /usr/local/bin/dind-cluster https://github.com/kubernetes-sigs/kubeadm-dind-cluster/releases/download/v0.1.0/dind-cluster-v1.13.sh
chmod +x /usr/local/bin/dind-cluster

./cassandra-k8s-operator/tools/create_dind_cluster.sh

#mkdir -p /opt/local-path-provisioner
#ssh node01 "mkdir -p /opt/local-path-provisioner"
#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
#kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

#kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-
