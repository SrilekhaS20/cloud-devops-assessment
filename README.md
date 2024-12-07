# Web Application Deployment on EKS with Monitoring

This repository provides an Infrastructure as Code (IaC) solution using Terraform to deploy a simple web application on Amazon Elastic Kubernetes Service (EKS). The solution includes containerizing the application with Docker, setting up Kubernetes deployment files, and integrating Prometheus for monitoring.

## Overview

This project demonstrates the steps to:

1. **Provision cloud infrastructure** using Terraform, including creating an Amazon EKS cluster.
2. **Containerize** a simple static web application using Docker.
3. **Deploy the web application** on EKS using Kubernetes manifests.
4. **Configure Prometheus** for monitoring the application and the EKS cluster.
5. **Enable logging** for the application.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- **Terraform** (v1.x)
- **kubectl** (v1.x)
- **AWS CLI** (v2.x)
- **Docker** (for containerizing the application)
- **eksctl** (optional, but recommended for EKS cluster management)

You should also have an **AWS account** and appropriate IAM roles for creating EKS and associated resources.

## Infrastructure Setup

### 1. Clone the Repository
```bash
git clone https://github.com/SrilekhaS20/cloud-devops-assessment.git
```
```bash
cd cloud-devops-assessment
```

### 2. Create Dockerfile
Dockerfile
```bash
FROM nginx:alpine

COPY ./static-page /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```
Build docker image
```bash
docker build -t cloud-devops-assessment:latest .
```
Start and run docker image as container
```bash
docker run -d -p 80:80 cloud-devops-assessment:latest
```
Tag docker image
```bash
docker tag cloud-devops-assessment:latest docker_username/cloud-devops-assessment:latest
```
Push the image to dockerhub
```bash
docker push docker_username/cloud-devops-assessment:latest
```

### 3. Create Terraform files
Create necessary terraform files to provision eks cluster in aws
After creating terraform files, Execute below commands to create resources in aws
```bash
terraform init
```
```bash
terraform plan
```
```bash
terraform apply
```

### 4. Create Kubernetes deployment files
Create deployment and services yaml files to provision node, namespaces, pods, deployments and services in aws

### 5. Connecting EKS cluster through EC2
```bash
aws configure
```
```bash
kubectl apply -f k8s/deployment.yaml
```
```bash
kubectl apply -f k8s/service.yaml
```

### 5. Create Prometheus to monitor EKS cluster
Create Prometheus deployment and services yaml files
```bash
kubectl apply -f k8s/prometheus/prometheus-deployment.yaml
```
```bash
kubectl apply -f k8s/prometheus/prometheus-service.yaml
```
```bash
kubectl apply -f k8s/prometheus/prometheus-configmap.yaml
```

### 5. Create Grafana to visualize the metrics in dashboard
Access grafana by applying below yaml files
```bash
kubectl apply -f k8s/grafana/grafana-deployment.yaml
```
```bash
kubectl apply -f k8s/grafana/grafana-service.yaml
```
