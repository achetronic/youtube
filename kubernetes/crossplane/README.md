# Crossplane

## Description

Deployment made using a combination of Helm and Kustomize to install Crossplane and 
AWS provider inside a Kubernetes cluster. 
This can be automated using GitOps approach using tools like FluxCD or ArgoCD

## Steps

1. Execute the following command to install Crossplane's operator

    ```
    helm dependency update
    helm upgrade --install crossplane ./000-operator --namespace crossplane --create-namespace
    ```

2. Apply the Kustomization to deploy the AWS provider

    ```
    kubectl apply -k ./001-provider/
    ```
3. Open the Secret resource which contains your AWS credentials and change them

   > As a security recommendation, generate this secret dynamically retrieving the credentials from a credentials vault 
   > like Hashicorp Vault using safe tools like External Secrets

    ```yaml
    # 002-provider-config/secret-aws-account-creds.yaml
    
    apiVersion: v1
    kind: Secret
    metadata:
      name: aws-account-creds
    type: Opaque
    stringData:
   
      # These credentials must be substituted by yours
      creds: ${AWS_ACCOUNT_CREDS}
    ```

4. Apply the Kustomization to deploy the configuration for AWS provider

    ```
    kubectl apply -k ./002-provider-config/
    ```
