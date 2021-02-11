#!/bin/bash
set -ex

kubectl delete -f /backup/mysql-sample-backup.yaml || :

kubectl apply -f /backup/mysql-sample-backup.yaml

counter=0

while [ $counter -lt 300 ]; do
  if [ "$(kubectl get backup mysql-label-backup -o go-template='{{ .status.phaseStatus }}')" == "Completed" ]; then
    echo "backup completed"
    exit 0
  fi
  let counter=counter+1
  sleep 5
done

if [ $counter -ge 300 ]; then
  echo "backup failed"
  exit 1
fi
