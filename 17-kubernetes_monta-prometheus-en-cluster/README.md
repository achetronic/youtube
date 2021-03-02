### Descripción
Estás viendo las instrucciones para montar un Prometheus en clúster dentro de Kubernetes, con alta disponibilidad, etc.
Este operador te crea varios recursos personalizados como los ServiceMonitor para agregar métricas de distintos servicios 
sin tirar el server Prometheus para recargar la configuración con los scrappers, etc. 

### Pasos
1. Instala el operador

``` 
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml
```
2. Aplica los manifiestos de RBAC

```
kubectl apply -f rbac/000-prometheus.yaml
kubectl apply -f rbac/001-prometheus-cluster-role.yaml
kubectl apply -f rbac/002-prometheus-cluster-role-binding.yaml
kubectl apply -f rbac/003-prometheus-service-account.yaml
```
3. Aplica los manifiestos para crear una app de ejemplo con un ServiceMonitor 

```
kubectl apply -f 000-example-app-deployment.yaml
kubectl apply -f 001-example-app-service.yaml
kubectl apply -f 002-example-app-service-monitor.yaml
```
4. Aplica los manifiestos para crear un ServiceMonitor para Prometheus y exponerlo al exterior

```
kubectl apply -f 003-prometheus-service-monitor.yaml
kubectl apply -f 004-prometheus-service.yaml
```