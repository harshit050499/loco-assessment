#!/bin/bash

#building the docker image
docker build -t flask_app .

#tagging the docker image for the push
docker tag flask_app:latest harshit05/flask_app:latest
docker push harshit05/flask_app:latest

#starting the minikube cluster
minikube start
minikube addons enable metrics-server #enabling metric-server for HPA
read -s -p "Enter sudo password: " PASSWORD
echo ""

# Run minikube tunnel with sudo password passed via echo
echo $PASSWORD | sudo -S minikube tunnel & # tunnel to create route for the Load Balancer type service

# Navigate to the kubernetes folder
cd kubernetes

#Creating namespace
kubectl create namespace loco
#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Kubernetes files in the desired order
files=("deployment.yml" "service.yml" "autoscale.yml")

# Apply each file in the specified order
for file in "${files[@]}"; do
    if kubectl apply -f "$file"; then
        echo "Successfully applied $file"
    else
        echo "Failed to apply $file"
        exit 1
    fi
done
