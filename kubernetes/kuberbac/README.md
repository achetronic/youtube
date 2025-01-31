# KubeRBAC

## Description

Deployment made using a combination of Helm and Kustomize to deploy KubeRBAC and
some DynamicClusterRole/DynamicRoleBindings resources.

## Steps

1. Execute the following command to deploy KubeRBAC

    ```
    helm dependency update ./000-operator
    helm upgrade --install kuberbac ./000-operator --namespace kuberbac --create-namespace
    ```

2. Execute the following command to deploy some custom resources

   ```
   kubectl apply -k ./002-dummy-extras
   ```
