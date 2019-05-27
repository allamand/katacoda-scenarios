# Check configuration

You should have 2 node kubernetes cluster (master and node0)

`k get nodes`{{execute}}



## Troubleshooting

If needed you can check for events on the cluster: 

`kubectl get events --sort-by .metadata.creationTimestamp --all-namespaces`{{execute}}
