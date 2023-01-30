## Steps to deploy Loki
1. Apply all YAML files in order and wait
```
kubectl apply -k .
```

2. Remember the FQDN
```
http://loki-service.kube-logging.svc.cluster.local:3100
```