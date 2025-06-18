FROM ubuntu:22.04

# Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common \
    lsb-release \
    git \
    python3 \
    python3-pip \
    unzip \
    jq \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install boto3 via pip
RUN pip3 install --no-cache-dir boto3

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && mv kubectl /usr/local/bin/

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip aws

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Flux CLI
RUN curl -s https://fluxcd.io/install.sh | bash

# Docker client already installed via `docker.io`

# Final sanity check
RUN kubectl version --client && \
    helm version && \
    aws --version && \
    az version && \
    flux --version && \
    git --version && \
    python3 --version && \
    pip3 show boto3 && \
    docker --version

CMD [ "bash" ]
