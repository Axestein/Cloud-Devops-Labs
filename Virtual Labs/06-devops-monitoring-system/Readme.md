# VLE 07 — Full DevOps Monitoring System (AWS + K8s + CI/CD + Alerts)

**Author:** Aditya Kumar Singh

## 🎯 Objective
To design and deploy an end-to-end DevOps monitoring system using **Amazon Web Services**, **Kubernetes**, **Jenkins**, **Prometheus**, **Grafana**, and **Prometheus Alertmanager**.

## 🏗️ System Architecture
1. Developer pushes code to GitHub
2. Jenkins builds and tests the Docker image
3. The application is deployed to the Kubernetes cluster
4. Prometheus scrapes metrics from the cluster
5. Grafana visualizes the metrics on dashboards
6. Alertmanager sends alerts on failures

## ✅ Prerequisites
- AWS account (Free tier / Educate)
- Ubuntu EC2 instance
- Basic knowledge of Docker & Kubernetes
- GitHub account

## 🛠️ Implementation

### Phase 1 — Infrastructure Setup on AWS
EC2 instance configuration:
- Name: `devops-monitoring-server`
- AMI: Ubuntu Server 22.04 LTS
- Instance type: `t2.medium` (2 vCPU, 4 GB RAM)
- Storage: 20 GB gp3
- Key pair: new `.pem` key

Security group inbound rules:

| Port | Protocol | Purpose |
|---|---|---|
| 22 | TCP | SSH administration |
| 8080 | TCP | Jenkins web interface |
| 3000 | TCP | Grafana dashboards |
| 9090 | TCP | Prometheus UI |
| 9093 | TCP | Alertmanager UI |
| 30000–32767 | TCP | Kubernetes NodePort range |

```bash
chmod 400 devops-key.pem
ssh -i devops-key.pem ubuntu@<EC2_PUBLIC_IP>
```

### Phase 2 — Base Tools Installation
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget unzip apt-transport-https ca-certificates gnupg

sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker

docker --version
docker run hello-world
```

### Phase 3 — Jenkins Installation and Configuration
```bash
sudo apt install -y fontconfig openjdk-21-jre
java -version

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins

sudo systemctl enable --now jenkins
sudo systemctl status jenkins

sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Unlocked Jenkins at `http://<EC2_PUBLIC_IP>:8080` and installed the extra plugins: **Docker Pipeline, Git, Kubernetes CLI, Kubernetes**.

The pipeline (see `Jenkinsfile` below) has stages **Checkout → Build → Load into Minikube → Deploy**, tags images as `myapp:v${BUILD_NUMBER}`, and waits for `kubectl rollout status` after deploying.

### Phase 4 — Kubernetes Cluster Setup (Minikube)
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --driver=docker

kubectl get nodes
minikube status
```

### Phase 5 — Sample Application Deployment
`deployment.yaml` defines an NGINX-based `myapp` Deployment (2 replicas) and a `NodePort` Service (`myapp-service`, port 80 → nodePort 30007).
```bash
kubectl apply -f deployment.yaml
kubectl get pods
kubectl get svc
curl http://$(minikube ip):30007
```

### Phase 6 — Prometheus and Grafana Monitoring Stack
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring
kubectl get pods -n monitoring
```
Exposed the UIs with port-forwarding (bound to `0.0.0.0` so they're reachable on the EC2 public IP):
```bash
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80 --address 0.0.0.0 &
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090 --address 0.0.0.0 &
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093 --address 0.0.0.0 &
```
Retrieved the Grafana admin password from the Kubernetes secret:
```bash
kubectl get secret -n monitoring monitoring-grafana \
  -o jsonpath="{.data.admin-password}" | base64 --decode; echo
```
- **Prometheus** (`:9090`) scraping all cluster endpoints
- **Grafana** (`:3000`) with Prometheus auto-provisioned as a data source; imported the **Node Exporter Full** community dashboard (ID 1860) for host-level CPU, memory, disk, and network metrics

### Phase 7 — Alerting with PrometheusRule and Alertmanager
Custom alert rules (`alert-rules.yaml`, a `PrometheusRule` in the `monitoring` namespace):

| Alert | Condition | Severity | Purpose |
|---|---|---|---|
| `PodCrashLoop` | Container restarts increase by more than 3 in 5 minutes (for 1m) | critical | Detects pods that repeatedly fail and restart |
| `HighCPUUsage` | Node CPU utilization above 80% for 2 minutes | warning | Detects sustained resource pressure |
| `NodeDown` | Node exporter `up` metric equals 0 for 1 minute | critical | Detects loss of a monitored node |

```bash
kubectl apply -f alert-rules.yaml
kubectl get prometheusrule -n monitoring
```
Simulated a failure to trigger `PodCrashLoop`:
```bash
kubectl run crash-test --image=busybox --restart=Always -- /bin/sh -c "exit 1"
kubectl get pods
kubectl delete pod crash-test   # clean up
```

## 📋 Expected Output (achieved)
- Live dashboards in Grafana
- Auto-deployment via Jenkins
- Alerts triggered on failures
- Multi-layer monitoring system

## 📎 Appendix (in the report)
- **A.** Full `Jenkinsfile`
- **B.** `deployment.yaml` (Deployment + NodePort Service)
- **C.** `alert-rules.yaml`
- **D.** Command cheat sheet (SSH, Docker, Jenkins, Minikube, kubectl, Helm, port-forwards, cleanup)

## 🎤 Sample Viva Questions
- **DevOps:** What is a CI/CD pipeline? CI vs. CD?
- **Kubernetes:** What is a Pod? Deployment vs. Service?
- **Monitoring:** What is Prometheus scraping? Why is Grafana used?
- **Alerts:** What is Alertmanager? What are alert rules?

## ✅ Result
Successfully designed and deployed a full DevOps monitoring system integrating Cloud (AWS), CI/CD (Jenkins), Containerization (Docker), Orchestration (Kubernetes), Monitoring (Prometheus + Grafana), and Alerting (Alertmanager).

## 📂 Contents of this Directory
| File | Description |
|---|---|
| `0916_VLE7.pdf` | Completed lab report (24 pages) — implementation phases with screenshots, alert rules, and appendix |
| `VLE-7.pdf` | Reference lab sheet — objective, architecture, phases, and viva questions |
| `README.md` | This file |