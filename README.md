# Cloud & DevOps Learning Labs

**Author:** Aditya Kumar Singh

A collection of hands-on AWS and DevOps labs completed as part of my coursework — covering core AWS services (EC2, S3, IAM, CloudWatch), Linux fundamentals, Git/GitHub CI-CD pipelines, Infrastructure as Code (Terraform), Configuration Management (Ansible), Containerization (Docker), and Orchestration (Kubernetes).

Each lab folder contains:
- A completed lab report (screenshots + step-by-step walkthrough)
- The original practice/reference sheet
- A `README.md` summarizing what was done
- (where applicable) the actual project source code used in the lab

---

## Repository Structure

```
cloud-devops-learning/
│
├── AWS Practice Labs/
│   ├── 01-ec2-instance/
│   │   ├── Lab-01-EC2-Instance-Deployment.pdf
│   │   ├── Practice - 1.pdf
│   │   └── README.md
│   │
│   ├── 02-s3-bucket/
│   │   ├── Lab-02-S3-Bucket-Management.pdf
│   │   ├── Practice - 2.pdf
│   │   └── README.md
│   │
│   ├── 03-iam/
│   │   ├── Lab-03-IAM-Secure-Access.pdf
│   │   ├── Practice - 3.pdf
│   │   └── README.md
│   │
│   └── 04-cloudwatch/
│       ├── Lab-04-CloudWatch-Monitoring.pdf
│       ├── Practice - 4.pdf
│       └── README.md
│
└── Virtual Labs/
    ├── 01-linux-commands/
    │   ├── Practices5.pdf
    │   ├── VLE-01-Linux-Commands.pdf
    │   ├── VLE_Linux.pdf
    │   └── README.md
    │
    ├── 02-git-github-actions-ci-cd/
    │   ├── project/
    │   ├── project-practice/
    │   ├── Github-Actions-Practice.pdf
    │   ├── VLE-02-Git-GitHub-CI-CD.pdf
    │   └── README.md
    │
    ├── 03-terraform-ansible/
    │   ├── project/
    │   ├── Terraform-ansible-VPN.pdf
    │   ├── VLE-03-Terraform-Ansible-AWS.pdf
    │   └── README.md
    │
    └── 04-end-to-end-devops/
        ├── Project/
        ├── End-to-End-CI-CD-Pipeline.pdf
        ├── VLE-04-End-to-End-DevOps-Pipeline.pdf
        └── README.md
```

---

## Lab Index

### AWS Practice Labs
| # | Lab | Focus | Details |
|---|---|---|---|
| 01 | [EC2 Instance Deployment](AWS%20Practice%20Labs/01-ec2-instance/README.md) | Launching & connecting to EC2, deploying Apache | t2.micro, Amazon Linux 2, SSH, `httpd` |
| 02 | [S3 Bucket Management](AWS%20Practice%20Labs/02-s3-bucket/README.md) | Object storage, versioning, lifecycle rules | Private bucket, Glacier lifecycle rule, AWS CLI |
| 03 | [IAM Secure Access](AWS%20Practice%20Labs/03-iam/README.md) | Identity & Access Management | IAM user, group, least-privilege S3 read-only policy |
| 04 | [CloudWatch Monitoring](AWS%20Practice%20Labs/04-cloudwatch/README.md) | Monitoring, alarms, dashboards | CPU alarm + SNS, CloudWatch Agent, custom dashboard |

### Virtual Labs
| # | Lab | Focus | Details |
|---|---|---|---|
| 01 | [Linux Commands](Virtual%20Labs/01-linux-commands/README.md) | Shell fundamentals | File I/O, redirection, STDIN/STDOUT/STDERR, `grep`/`cut`/`awk`, AWS CLI setup |
| 02 | [Git, GitHub & CI/CD](Virtual%20Labs/02-git-github-actions-ci-cd/README.md) | Version control + automation | GitHub Actions CI pipeline, Slack ChatOps, Vercel CD |
| 03 | [Terraform + Ansible](Virtual%20Labs/03-terraform-ansible/README.md) | Infrastructure as Code + Config Mgmt | VPC/subnet/EC2 via Terraform, Docker install via Ansible |
| 04 | [End-to-End DevOps Pipeline](Virtual%20Labs/04-end-to-end-devops/README.md) | Full-stack automation | Git → Terraform → Ansible → Docker → Kubernetes → GitHub Actions |

---

## Tech Stack Covered

| Category | Tools |
|---|---|
| Cloud Provider | AWS (EC2, S3, IAM, CloudWatch, VPC) |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Containerization | Docker |
| Orchestration | Kubernetes (Minikube) |
| CI/CD | GitHub Actions |
| ChatOps | Slack (Incoming Webhooks) |
| Static Hosting / CD | Vercel |
| OS / Shell | Linux (Amazon Linux 2/2023, Ubuntu/WSL) |
| CLI Tools | AWS CLI, kubectl, ansible-playbook |

## Purpose
This repository serves as a personal learning log and portfolio, documenting hands-on practice with core cloud infrastructure concepts and modern DevOps automation workflows — moving progressively from manual AWS console operations to fully automated, Infrastructure-as-Code-driven CI/CD pipelines.

## How to Navigate
Each numbered lab folder is self-contained — open its `README.md` for the objective, step-by-step procedure, commands used, and outcome. The original lab report (with screenshots) and reference/practice sheet are included alongside for full context.
