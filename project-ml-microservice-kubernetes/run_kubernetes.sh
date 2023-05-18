#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
docker_path=haitv97

# Step 2
# Run the Docker Hub container with kubernetes
kubectl create deploy project-ml-microservice-kubernetes --image="$docker_path/devops"


# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward deployment.apps/project-ml-microservice-kubernetes 8000:80
