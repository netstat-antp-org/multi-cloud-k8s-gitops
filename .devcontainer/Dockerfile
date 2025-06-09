FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install core utilities
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    vim \
    bash-completion \
    ca-certificates \
    gnupg \
    software-properties-common \
    lsb-release \
    jq \
    apt-transport-https \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

#Terraform alias
RUN echo "alias tf='terraform'" >> /etc/bash.bashrc

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Google Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update && apt-get install -y google-cloud-sdk

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Install eksctl
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip \
    && unzip terraform_1.7.5_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_1.7.5_linux_amd64.zip

# Install yq (YAML processor)
RUN wget https://github.com/mikefarah/yq/releases/download/v4.40.5/yq_linux_amd64 -O /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# Install Flux CLI
RUN curl -s https://fluxcd.io/install.sh | bash

# Install ArgoCD CLI
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.11.0/argocd-linux-amd64 \
    && chmod +x /usr/local/bin/argocd

# (Optional) Install OPA CLI for policy-as-code
RUN curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64_static \
    && chmod +x opa \
    && mv opa /usr/local/bin/

# (Optional) Install kubeseal for SealedSecrets
RUN curl -L -o kubeseal https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.23.0/kubeseal-linux-amd64 \
    && chmod +x kubeseal \
    && mv kubeseal /usr/local/bin/

# Set working directory
WORKDIR /workspace

# Default to bash
CMD ["/bin/bash"]