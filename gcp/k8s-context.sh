#!/bin/bash
export KUBECONFIG=~/.kube/config
export K8S_CONTEXT="gke_multi-cloud-k8s-461703_us-east1_multi-cloud-gke2"
alias k8s="kubectl --context=$K8S_CONTEXT"
echo "GCP GKE context set: $K8S_CONTEXT"