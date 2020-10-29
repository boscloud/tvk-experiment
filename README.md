# TrilioVault for Kubernetes - Red Sky Experiment

## Introduction
This is a simple performance testing and optimization experiment for TrilioVault for Kubernetes.

based on 'Getting Started' guide - https://docs.trilio.io/kubernetes/use-triliovault/installing-triliovault

## Prerequisites

### Install CSI Driver

https://docs.trilio.io/kubernetes/appendix/csi-drivers/hostpath-for-tvk
```
cd csi-driver-host-path/deploy/kubernetes-1.18
```
#### Change to the latest supported snapshotter version
```
SNAPSHOTTER_VERSION=v2.0.1
```
#### Apply VolumeSnapshot CRDs

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${SNAPSHOTTER_VERSION}/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${SNAPSHOTTER_VERSION}/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${SNAPSHOTTER_VERSION}/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
```

#### Create snapshot controller
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${SNAPSHOTTER_VERSION}/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${SNAPSHOTTER_VERSION}/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml
```

```
./deploy.sh
```

### Update Trilio-Operator and Trilio-Manager Helm Charts, Install TrilioVault-Operator
```
helm repo add triliovault-operator http://charts.k8strilio.net/trilio-stable/k8s-triliovault-operator
helm repo add triliovault http://charts.k8strilio.net/trilio-stable/k8s-triliovault
helm repo update
helm install triliovault-operator triliovault-operator/k8s-triliovault-operator --version 1.1.0
```

### Install CockroachDB sample app via Helm v3
```
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
helm install cockroachdb-app --values setup/cockroachdb-values.yaml stable/cockroachdb
```

### Create configmap to inject an executable script into Trial container and map the backup.yaml to the Trial pod
```
kubectl create configmap wrapper --from-file=trial-configmaps/wrapper.sh

kubectl create configmap backuptrial --from-file=trial-configmaps/backup.yaml
```

### Run the Experiment File

kubectl apply -f experiment-simple-backup.yaml
