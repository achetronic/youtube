### Description
Deployment made using a combination of Helm and Kustomize to install 
Hashicorp Vault (in development mode) and External Secrets inside a Kubernetes cluster.
This can be automated using GitOps approach as I wrote in the official
[documentation page](https://external-secrets.io/guides-gitops-using-fluxcd/)


### Steps
1. Install Hashicorp Vault inside your Kubernetes cluster

```console
helm repo add hashicorp https://helm.releases.hashicorp.com

helm install vault hashicorp/vault --namespace vault --create-namespace -f hashicorp-vault/values.yaml
```

2. Install External Secrets inside the cluster

```console
helm repo add external-secrets https://charts.external-secrets.io

helm install external-secrets \
   external-secrets/external-secrets \
    --namespace external-secrets \
    --create-namespace \
    --set installCRDs=true
```

3. Deploy the Secret and CRs to grant access to Vault from External Secrets

```console
kubectl apply -k external-secrets
```
