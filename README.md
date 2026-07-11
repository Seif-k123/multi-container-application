# Multi-Container Application

A production-ready DevOps project that demonstrates how to build, provision, configure, and deploy a multi-container application using modern DevOps tools and AWS.

## Overview

This project automates the complete deployment lifecycle of a Todo API by combining:

* Containerization with Docker
* Multi-container orchestration with Docker Compose
* Infrastructure as Code using Terraform
* Configuration management with Ansible
* Continuous Integration and Continuous Deployment (CI/CD) with Jenkins
* Deployment to AWS EC2

## Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
Jenkins Pipeline
    │
    ├── Checkout Source
    ├── Build Docker Image
    ├── Push Image to Docker Hub
    └── Deploy with Ansible
                │
                ▼
             AWS EC2
                │
        Docker Compose
        ┌──────────────┐
        │  Node.js API │
        │   MongoDB    │
        └──────────────┘
```

## Technology Stack

| Category                 | Technologies           |
| ------------------------ | ---------------------- |
| Backend                  | Node.js, Express       |
| Database                 | MongoDB, Mongoose      |
| Containers               | Docker, Docker Compose |
| Infrastructure           | Terraform              |
| Configuration Management | Ansible                |
| CI/CD                    | Jenkins                |
| Cloud                    | AWS EC2                |
| Version Control          | Git, GitHub            |

## Project Structure

```text
.
├── api/
├── ansible/
├── terraform/
├── docker-compose.yml
├── .gitignore
├── Jenkinsfile
└── README.md
```

## Features

* RESTful Todo API
* Persistent MongoDB storage
* Dockerized application
* Multi-container deployment with Docker Compose
* Infrastructure provisioning with Terraform
* Automated server configuration using Ansible
* Automated deployment with Jenkins
* Reproducible and scalable deployment workflow

## Prerequisites

Before running the project, ensure you have:

* Docker
* Docker Compose
* Terraform
* Ansible
* Git
* AWS Account
* Docker Hub Account
* Jenkins Server

## Local Development

Clone the repository:

```bash
git clone git@github.com:Seif-k123/multi-container-application.git
cd multi-container-application
```

Start the application:

```bash
docker compose up -d
```

Stop the application:

```bash
docker compose down
```

The API will be available at:

```text
http://localhost:3000
```

## Infrastructure Deployment

Initialize Terraform:

```bash
cd terraform
terraform init
```

Review the execution plan:

```bash
terraform plan
```

Provision the infrastructure:

```bash
terraform apply
```

Terraform automatically generates the Ansible inventory after deployment.

## Server Configuration

Configure the EC2 instance:

```bash
cd ../ansible
ansible-playbook -i inventory.ini playbook.yml
```

This playbook:

* Installs Docker Engine
* Installs Docker Compose Plugin
* Starts and enables the Docker service
* Configures Docker permissions

## CI/CD Pipeline

The Jenkins pipeline automates the deployment process:

1. Checkout the latest source code
2. Build the Docker image
3. Push the image to Docker Hub
4. Deploy the latest version to AWS EC2
5. Restart the application using Docker Compose

## API Endpoints

| Method | Endpoint     | Description           |
| ------ | ------------ | --------------------- |
| GET    | `/todos`     | Retrieve all todos    |
| POST   | `/todos`     | Create a new todo     |
| GET    | `/todos/:id` | Retrieve a todo by ID |
| PUT    | `/todos/:id` | Update a todo         |
| DELETE | `/todos/:id` | Delete a todo         |

## Future Improvements

* Nginx Reverse Proxy
* HTTPS with Let's Encrypt
* Prometheus Monitoring
* Grafana Dashboards
* Kubernetes Deployment
* Helm Charts
* GitOps with Argo CD

## Author

**Seif Khaled**


