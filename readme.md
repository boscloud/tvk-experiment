# TrilioVault for Kubernetes - StormForge Experiment

## Introduction
This is a simple performance testing and optimization experiment for TrilioVault for Kubernetes.

based on 'Getting Started' guide - https://docs.trilio.io/kubernetes/use-triliovault/installing-triliovault

### Create configmaps

#### Configmap TVK yaml files for Backup
```
kubectl create configmap backup --from-file=tvk/mysql-sample-backup.yaml
```

#### Configmap the patchable manifest for TVK Manager
```
kubectl create configmap tvkmanager --from-file=tvk/tvk-manager.yaml 
```

#### Confimap the bash script (This executes the backup/restore .yaml files every trial run)
```
kubectl create configmap bashscript --from-file=tvk/bash-script.sh
```

### Run the Experiment File
```
kubectl apply -f stormforge/manifest-patch-experiment.yaml
```
#### Delete and clean up experiment on app.stormforge ML tenant
```
redskyctl delete exp tvk-backup
```
#### Delete and clean up Eeperiment on local cluster
```
redskyctl delete exp tvk-backup

kubectl delete -f stormforge/manifest-patch-experiment.yaml
```