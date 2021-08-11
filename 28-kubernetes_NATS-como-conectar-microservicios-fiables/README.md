### Description
Applying these manifests, you are installing the NATS operator in Cluster mode. This implies that you are planning
only to have one NATS cluster for every projects on the cluster. Do this only if you are sure you want this made this way.


### Steps
1. Install the operator in cluster mode

```
kubectl apply -k .
```
2. Create your NATS cluster (take care, you can create is under TLS too)

```
kubectl apply -f natsCluster.yaml
```

### Test the cluster
1. Download and install NATS CLI binary from https://github.com/nats-io/natscli/releases
2. Create a context pointing your NATS service
```
nats context add nats --server YOUR_CLUSTER_SERVICE:4222 --description "My NATS Cluster Service" --select
```
3. Interact with it
```
nats sub "channel.subchannel"
nats pub "channel.subchannel" "Hello, I am your father"
```