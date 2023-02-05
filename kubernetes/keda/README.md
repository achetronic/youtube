# Keda

## Description

Deployment made using a combination of Helm and Kustomize to deploy Keda and
a dummy Deployment which is scaled depending on the size of a Redis queue.

## Steps

1. Execute the following command to deploy Keda

    ```
    helm dependency update ./000-operator
    helm upgrade --install keda ./000-operator --namespace keda --create-namespace
    ```

2. Execute the following command to deploy Redis

   > DISCLAIMER: included Redis is not intended for production. 
   > In that case, Sentinel or cluster is needed.

   ```
   helm dependency update ./001-dummy-redis
   helm upgrade --install redis ./001-dummy-redis --namespace application --create-namespace
   ```

3. Execute the following command to deploy a dummy application with a scaler triggered by Redis queue size

   ```
   kubectl apply -k ./002-dummy-deployment
   ```
