# Introduction
This folder contains the manifests to create some ServiceAccount resources with some Role resources binded giving the accounts some permissions inside the cluster

# How to do it
1. You have to apply all manifests step by step

```
cd application-a

kubectl apply -k .
```

2. Check if a ServiceAccount can do some tasks
```
kubectl auth can-i --as system:serviceaccount:application-a:automata get pods -n application-a

kubectl auth can-i --as system:serviceaccount:application-a:automata get secrets -n application-a
```