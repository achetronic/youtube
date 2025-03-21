# Gateway API + Istio

## Description

Deployment made using a combination of Helm and Kustomize to deploy Gateway API (controlled by Istio) and
some Gateway/HTTPRoute resources.

## Steps

1. Execute the following command to deploy Gateway API CRDs

   ```
   kubectl apply -k ./000-gateway-api-crds/v1.2.1
   ```

2. Execute the following command to deploy Istio base CRDs

    ```
    helm dependency update ./001-istio-crds
    helm upgrade --install istio-base ./001-istio-crds --namespace istio-system --create-namespace
    ```

3. Execute the following command to deploy Istio control plane

    ```
    helm dependency update ./002-istio-control-plane
    helm upgrade --install istio-discovery ./002-istio-control-plane --namespace istio-system --create-namespace
    ```

4. Execute the following command to deploy a Gateway and some HTTPRoute resources

   ```
   kubectl apply -k ./003-gateway-api-extra
   ```