### Descripción
Estás viendo las instrucciones para montar un Prometheus en clúster dentro de Kubernetes, con alta disponibilidad, etc.
Este operador te crea varios recursos personalizados como los ServiceMonitor para agregar métricas de distintos servicios 
sin tirar el server Prometheus para recargar la configuración con los scrappers, etc. 

### Pasos
1. Instala el operador

``` 
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml
```
2. Aplica los manifiestos para levantar Prometheus (RBAC, servicio, etc)

```
kubectl apply -k prometheus/
```
3. Aplica los manifiestos para crear una app de ejemplo con un ServiceMonitor 

```
kubectl apply -k example-app/
```

### ¿Por qué tan fácil?
Si te fijas, el manifiesto YAML que estás aplicando en cada directorio es un kustomization.yaml que he creado, que se encarga 
de aplicar el resto de manifiestos uno por uno. Así que en vez de levantarlos a mano, los levanta de forma automática.