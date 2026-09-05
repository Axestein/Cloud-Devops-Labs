# VLE 04 — End-to-End DevOps CI/CD Pipeline

**Author:** Aditya Kumar Singh

## Aim
To design and implement a complete DevOps pipeline where infrastructure is provisioned using **Terraform**, servers are configured using **Ansible**, application containers are built using **Docker**, deployed on **Kubernetes**, and automated using **GitHub Actions** CI/CD.

## Scenario (Real-Time Use Case)
A startup wants to deploy a web application with zero manual intervention. Requirements:
- Infrastructure should be created automatically
- Application should be containerized
- Deployment should be scalable
- Any code change should trigger automatic deployment

**Solution Stack:**

| Requirement | Tool |
|---|---|
| Version Control | Git |
| CI/CD | GitHub Actions |
| Infrastructure Provisioning | Terraform |
| Configuration Management | Ansible |
| Containerization | Docker |
| Orchestration | Kubernetes (Minikube) |

## Architecture Overview
1. Developer pushes code to GitHub
2. GitHub Actions pipeline triggers automatically
3. Terraform creates VM / cloud infrastructure
4. Ansible installs Docker & Kubernetes dependencies
5. Docker builds the application image
6. Kubernetes deploys the containerized application

## Tools & Technologies
Git & GitHub · GitHub Actions · Terraform · Ansible · Docker · Kubernetes (Minikube) · Linux (Ubuntu / Amazon Linux)

## System Requirements
- OS: Linux / Windows / macOS
- RAM: Minimum 8 GB
- GitHub account
- Docker & Minikube installed (for local lab)

## Project Directory Structure
```
devops-virtual-lab/
├── app/
│   ├── index.html
│   └── Dockerfile
├── terraform/
│   └── main.tf
├── ansible/
│   ├── inventory.ini
│   └── setup.yml
├── k8s/
│   ├── deployment.yml
│   └── service.yml
└── .github/workflows/
    └── cicd.yml
```

## Step-by-Step Implementation

### PART A — Git & Application Setup
```bash
git init
git branch -M main
mkdir app
```
Created `app/index.html` — a simple "DevOps CI/CD Virtual Lab" page, later styled with a gradient background/card layout, showing tools used and a version tag.

Installed **kubectl** and **Minikube** locally (via `curl`/Chocolatey) to support the Kubernetes deployment steps.

### PART B — Docker Implementation
`app/Dockerfile`:
```dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
```
Built and tested the image locally:
```bash
docker build -t devops-lab-app ./app
docker run -d -p 8080:80 --name devops-app devops-lab-app
```
Verified the running app at `http://localhost:8080`. Loaded the built image directly into Minikube for the Kubernetes step:
```bash
docker tag devops-lab-app devops-lab-app:latest
minikube image load devops-lab-app:latest
```

### PART C — Terraform (Infrastructure as Code)
`terraform/main.tf` provisions:
- AWS provider (`us-east-1`)
- A security group (`devops-sg`) allowing inbound SSH (22), HTTP (80), and app port (8080)
- An EC2 instance (`aws_instance.devops_server`, `t2.micro`, keyed with `my-key`)

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
Output confirmed instance creation, e.g.:
```
instance_public_dns = "ec2-54-152-160-26.compute-1.amazonaws.com"
instance_public_ip  = "54.152.160.26"
```

### PART D — Ansible (Configuration Management)
`ansible/inventory.ini`:
```ini
[servers]
server1 ansible_host=<PUBLIC_IP>

[servers:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=my-key.pem
```
`ansible/setup.yml` — installs Docker, starts/enables the service, adds the user to the `docker` group, and installs `kubectl` and Minikube.

```bash
ansible-playbook -i inventory.ini setup.yml
```
Play recap: `ok=7  changed=6  unreachable=0  failed=0` — Docker, Kubectl, and Minikube installed successfully on `server1`.

### PART E — Kubernetes Deployment
`k8s/deployment.yml` — Deployment `devops-app`, 2 replicas, container `devops-lab-app` on port 80.
`k8s/service.yml` — Service `devops-service`, type `NodePort`, port 80 → target port 80.

```bash
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl get pods
kubectl get services
kubectl get deployments
```
Verified 2/2 pods `Running`, service `devops-service` exposed as NodePort (`80:30001/TCP`), and deployment showing `2/2` up-to-date/available replicas.

### PART F — GitHub Actions (CI/CD Automation)
`.github/workflows/cicd.yml`:
```yaml
name: DevOps CI/CD Pipeline
on:
  push:
    branches: [ "main" ]
jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
      - name: Build Docker Image
        run: docker build -t devops-lab-app ./app
      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s/deployment.yml
          kubectl apply -f k8s/service.yml
```
```bash
git add .
git commit -m "End-to-End DevOps Virtual Lab"
git push origin main
```
Pushing to `main` triggers the CI/CD pipeline automatically.

### Final Verification
Ran an end-to-end verification pass — confirmed the Docker image, running pods, the exposed `devops-service` (accessed via `minikube service devops-service --url` and `curl`), and all Kubernetes nodes/deployments healthy, with a final **"All components verified successfully!"** confirmation.

🔗 **Repository:** https://github.com/Axestein/DevOps-VLE5

## Observations
- Infrastructure created automatically using Terraform
- Server configured using Ansible
- Application containerized using Docker
- Application deployed and scaled using Kubernetes
- CI/CD automated using GitHub Actions

## Result
An end-to-end automated DevOps pipeline was successfully implemented using Git, GitHub Actions, Terraform, Ansible, Docker, and Kubernetes.

## Viva Voce Question Bank
The lab report includes a comprehensive Q&A prep list covering:
- **Git** (branching, merge vs. rebase, reset types, detached HEAD, CI/CD relevance)
- **GitHub** (fork vs. clone, issues, organizations, webhooks, secrets, collaboration)
- **GitHub Actions** (jobs, steps, runners, secrets, Docker/Kubernetes automation, vs. Jenkins)
- **Docker** (containers vs. VMs, images, Dockerfile, volumes, lifecycle, microservices)
- **Kubernetes** (Pods, Deployments, Services, NodePort, ReplicaSets, scaling, HA, vs. Docker Swarm)
- **Integration/DevOps flow** (end-to-end git-push-to-deployment flow, CI vs. CD, real-time use cases)

See `VLE-04-End-to-End-DevOps-Pipeline.pdf` for the full question list.

## Contents of this Directory
| File / Folder | Description |
|---|---|
| `VLE-04-End-to-End-DevOps-Pipeline.pdf` | Completed lab report with terminal output, screenshots, and viva voce question bank |
| `End-to-End_CI-CD_Pipeline.pdf` | Reference lab sheet — aim, scenario, architecture, and full step-by-step procedure |
| `project/` | Full pipeline source (`app/`, `terraform/`, `ansible/`, `k8s/`, `.github/workflows/`) — mirrors the [DevOps-VLE5](https://github.com/Axestein/DevOps-VLE5) repository |
| `README.md` | This file |