# Deployment for grafana

## Steps
1. Apply all YAML files using Kustomize
```
kubectl apply -k .
```
2. kubectl port-forward service/grafana-service 80:80
