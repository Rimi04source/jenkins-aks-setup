#!/bin/bash
set -e
echo " Jenkins Installation on AKS "
NAMESPACE="jenkins"
RELEASE_NAME="jenkins"
VALUES_FILE="helm/jenkins-values.yaml"

echo "Checking prerequisites"
command -v kubectl >/dev/null 2>&1 || {
  echo "kubectl not found"
  exit 1
}

command -v helm >/dev/null 2>&1 || {
  echo "helm not found"
  exit 1
}

echo "kubectl and helm found"

echo "Adding Jenkins Helm repository"
helm repo add jenkins https://charts.jenkins.io || true
helm repo update

echo "Creating namespace (if not exists)..."
kubectl get namespace $NAMESPACE >/dev/null 2>&1 || \
kubectl create namespace $NAMESPACE

echo "Installing Jenkins using Helm"
helm upgrade --install $RELEASE_NAME jenkins/jenkins \
  --namespace $NAMESPACE \
  -f $VALUES_FILE

echo "Waiting for Jenkins pod to be ready"
kubectl rollout status deployment/jenkins -n $NAMESPACE

echo " Jenkins Installed Successfully"
echo "Fetching Jenkins Service details"
kubectl get svc -n $NAMESPACE
