# Deployment to Kubernetes Cluster with Azure Devops Pipeline & Argo CD

This repository contains a sample setup for deploying an Nginx container in a Kubernetes cluster. It uses Azure Pipeline for automating the Docker build and push processes and Argo CD for continuous deployment to a Kubernetes cluster.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [Azure Pipeline Setup](#azure-pipeline-setup)
  - [Argo CD Setup](#argo-cd-setup)
- [Deployment Process](#deployment-process)

## Prerequisites

Before you begin, ensure you have the following tools and access:

- **Azure DevOps Account**: For setting up the CI/CD pipeline.
- **Kubernetes Cluster**: To deploy the application using Argo CD.

## Setup Instructions

1. The `Dockerfile` located in the root of this repository builds a custom Nginx image.
2. The `index.html` file contains the sample content that will be served by Nginx.
3. azure-pipelines.yml file builds and push image to ACR repo and updates the tag to nginx-deployment/deploy-nginx.yaml file.
4. ArgoCD will detect the changes from the file deploy-nginx.yaml and deploy.

```ArgoCD setup

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#To make ArgoCD accessible from outside
k patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

Create Application using CLI
argocd app create webapp --repo $REPO_URL --path nginx-deployment/ --dest-server https://kubernetes.default.svc --dest-namespace nginx
argocd app sync webapp
```




