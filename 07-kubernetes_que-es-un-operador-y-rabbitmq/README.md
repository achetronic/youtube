# Introduction
This folder contains the files to create a RabbitMQ cluster based on the 
rabbitmq operator, which has to be installed into Kubernetes

# Installation: Official
1. You must have the RabbitMQ Operator in the cluster. Check it executing the following:
```
kubectl get customresourcedefinitions.apiextensions.k8s.io

# NAME                                   CREATED AT
# rabbitmqclusters.rabbitmq.com   2019-10-23T10:11:06Z
```

If you don't have it installed, you just have to install it applying this file:
```
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
```

2. The second step is to apply the files in the right order. 

If you have any doubt, there is a link 
where you can read the installation instructions [here](https://www.rabbitmq.com/kubernetes/operator/install-operator.html)

3. Extra

Configure TLS for safe connections

```
TLS Configuration
Description: Configure RabbitMQ to use the certificates provided by Secret spec.tls.secretName. The Secret must already exist in the same Namespace as the RabbitmqCluster object. It is expected that the Secret contains tls.key and tls.crt for the private key and public certificate respectively.

Optionally, configure RabbitMQ to connect using mutual TLS authentication (mTLS) by providing a CA certificate to verify peer certificates against. This certificate must be stored under a key of name spec.tls.caCertName, in a Secret of name spec.tls.caSecretName, in the same Namespace as the RabbitmqCluster object. Note that this can be the same Secret as spec.tls.secretName.
```

Obtain user and password

```
kubectl -n default get secret rabbitmqcluster-rabbitmq-default-user -o jsonpath="{.data.username}" | base64 --decode
kubectl -n default get secret rabbitmqcluster-rabbitmq-default-user -o jsonpath="{.data.password}" | base64 --decode
```


