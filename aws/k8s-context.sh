#!/bin/bash

export KUBECONFIG=~/.kube/config
export K8S_CONTEXT="arn:aws:eks:us-east-1:401989963502:cluster/multi-cloud-eks"
alias k8s="kubectl --context=$K8S_CONTEXT"
echo "✅ AWS EKS context set: $K8S_CONTEXT"