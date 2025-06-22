#!/bin/bash
export KUBECONFIG=~/.kube/config
export K8S_CONTEXT="multi-cloud-aks"
alias k8s="kubectl --context=$K8S_CONTEXT"
echo "Azure AKS context set: $K8S_CONTEXT"