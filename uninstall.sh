#!/bin/bash
set -e
echo " Jenkins Uninstallation from AKS"

NAMESPACE="jenkins"
RELEASE_NAME="jenkins"

echo "Uninstalling Jenkins Helm release"
helm uninstall $RELEASE_NAME -n $NAMESPACE || true

echo "Deleting Persistent Volume Claims"
kubectl delete pvc -n $NAMESPACE --all || true

echo "Deleting namespace"
kubectl delete namespace $NAMESPACE || true
echo " Jenkins Completely Removed"
