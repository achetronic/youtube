### Description
These manifests create a pod with Kaniko that downloads a Git repository and builds its image.
After building, push it to a Docker Hub repository


### Steps
1. Create a Secret with Docker credentials to be authenticated into Docker Hub
```
kubectl create secret docker-registry docker-hub --docker-server=https://index.docker.io/v1/ --docker-username=<YOUR USER> --docker-password=<YOUR API TOKEN>
```

2. Apply the Kustomization
```
kubectl apply -k .
```

3. See the magic happening
```
kubectl logs -f kaniko
```
