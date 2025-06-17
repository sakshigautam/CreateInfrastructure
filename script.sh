#!/bin/bash
 
# ----------- Configuration Variables -----------
RESOURCE_GROUP="your-resource-group-name"
CLUSTER_NAME="your-aks-cluster-name"
SUBSCRIPTION_ID="your-azure-subscription-id"
NAMESPACE="your-kubernetes-namespace-name"
# -----------------------------------------------
 
# Step 1: Log in to Azure
echo "Logging into Azure..."
az login --only-show-errors
az account set --subscription "$SUBSCRIPTION_ID"
 
# Step 2: Get AKS Cluster credentials
echo "Fetching AKS credentials for cluster: $CLUSTER_NAME"
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" --overwrite-existing
 
# Step 3: Create Kubernetes namespace
echo "Creating namespace: $NAMESPACE"
kubectl create namespace "$NAMESPACE"
 
# Check if creation was successful
if [ $? -eq 0 ]; then
    echo "Namespace '$NAMESPACE' created successfully."
else
    echo "Failed to create namespace '$NAMESPACE' or it already exists."
fi
