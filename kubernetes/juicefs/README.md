# JuiceFS

## Description

This document will guide on the deployment and usage of JuiceFS inside a Kubernetes cluster.

All the pieces will live inside Kubernetes, but it can be deployed using other spells of arcane magic.

JuiceFS deployment is not super documented on the website and some of the following steps can be automated, such as the
secrets' creation.


> [!TIP]
> To test this guide in KIND Kubernetes, you need to solve some
> [issues](https://github.com/juicedata/juicefs-csi-driver/issues/1297)
> 
> Don't worry, there is a fix: [fix](https://kind.sigs.k8s.io/docs/user/known-issues/#pod-errors-due-to-too-many-open-files)

## Steps

### 1. Metadata server

Deploy the metadata server. This will store the location of the chunks in your object storage, the path of the files
(as they are divided in several chunks), etc. Be super careful with this server as it stores the most important data.

Several types of databases can be used as metadata server, such as Postgres, Redis, Etcd or MariaDB.
Redis is less reliable but has higher performance. Because of that, It's better to use it in cluster mode preventing data lost.

Redis is configured with authentication enabled. The secret can be provisioned in a plenty of ways, but I recommend you
to use External Secrets and a credentials vault such as Hashicorp Vault. 
Videos for both them can be found in my Youtube channel.

```console
export METADATA_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)

kubectl create ns juicefs

kubectl -n juicefs create secret generic metadata-redis-cluster \
  --from-literal=redis-password=${METADATA_PASSWORD}


helm dependency update ./00-metadata-server

helm upgrade --install --timeout 600s metadata --namespace juicefs --create-namespace ./00-metadata-server
```

### 2. Create the filesystem using Metadata + S3

Now it's time to create the filesystem. It's super easy to do, and it's only needed to be done once, 
so it's not a bad idea to launch it by hand and run for your life. Anyway, if you prefer to automate 
this one-shot step, Bash, Ansible and company are there for you.

```console
# Format your metadata and storage
kubectl run juicefs-format \
  --image=juicedata/mount:ce-v1.2.3 \
  --restart=Never \
  --env STORAGE=s3 \
  --env BUCKET=https://xxxEXAMPLExxx \
  --env ACCESS_KEY=xxxEXAMPLExxx \
  --env SECRET_KEY=xxxEXAMPLExxx \
  --env METADATA_PASSWORD=${METADATA_PASSWORD} \
  --command -- /bin/sh -c '
    juicefs format \
      --storage ${STORAGE} \
      --bucket ${BUCKET} \
      --access-key ${ACCESS_KEY} \
      --secret-key ${SECRET_KEY} \
      redis://:${METADATA_PASSWORD}@metadata-redis-cluster.juicefs.svc:6379/1 \
      juice-filesystem-01
  '

# Check the result
kubectl logs juicefs-format
```

### 3. Deploy and connect your CSI driver to your filesystem

Create the secret for the CSI driver to access your volume. 
More information into the [official docs](https://juicefs.com/docs/csi/guide/pv/#community-edition)

```console
kubectl create secret generic juicefs-credentials \
  --namespace=juicefs \
  --from-literal=name=<JUICEFS_NAME> \
  --from-literal=metaurl=<META_URL> \
  --from-literal=storage=s3 \
  --from-literal=bucket=https://<BUCKET>.s3.<REGION>.amazonaws.com \
  --from-literal=access-key=<ACCESS_KEY> \
  --from-literal=secret-key=<SECRET_KEY>
```

Deploy the CSI driver with sane defaults:

```console
helm dependency update ./01-csi-driver

helm upgrade --install --timeout 600s csi-driver --namespace juicefs --create-namespace ./01-csi-driver
```

### 4. Deploy an application to test everything

```console
kubectl apply -k ./02-application
```

Now, if everything is done right, you can write a file inside `/usr/share/nginx/html` directory, and will appear
immediately in the same dir, but in the other pod. Come on, test it!