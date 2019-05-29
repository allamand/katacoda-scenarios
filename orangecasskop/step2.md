# Deploy CassKop 

CassKop is composed of a specific CRD (Custom Ressource Definition) and a controller.
We are going to apply directly the crd manifest, then deploy the CassKop using helm

## Deploy CassKop CRD

`k apply -f deploy/crds/db_v1alpha1_cassandracluster_crd.yaml`{{execute}}

## Deploy CassKop's operator

`helm install --name cassandra-demo ./helm/cassandra-k8s-operator`{{execute}}

Wait some seconds for the CassKop to be up and runnin

`k get pods -o wide`{{execute}}


You can see the operator's logs: 

`k logs -l app=cassandra-k8s-operator`{{execute}}

For now CassKop is not doing anything, it is waiting for CassandraCluster object creation.

