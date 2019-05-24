# Deploy CassKop 

CassKop is composed of a specific CRD (Custom Ressource Definition) and a controller.
We are going to apply directly the crd manifest, then deploy the CassKop using helm

## Deploy CassKop CRD

`k apply -f deploy/crds/db_v1alpha1_cassandracluster_crd.yaml`{{execute}}`

## Deploy CassKop's operator

`helm install --name cassandra-demo ./helm/cassandra-k8s-operator`{{execute}}`
```

check operator's logs: 

`k logs -l app=cassandra-k8s-operator --tail=10`{{execute}}`

quit with Ctrl-C
