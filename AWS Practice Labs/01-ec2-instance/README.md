# Lab 01 — Deploy and Manage an EC2 Instance

**Author:** Aditya Kumar Singh 

## Objective
- Launch and connect to an Amazon EC2 instance
- Configure a web server on the instance

## Introduction
Amazon Elastic Compute Cloud (EC2) is a core AWS service that provides resizable virtual servers ("instances") in the cloud. It lets you provision compute capacity on demand — without owning physical hardware — while giving full control over the OS, networking, and installed software. This lab walks through the complete lifecycle: launching an instance, connecting to it securely over SSH, and deploying a working Apache web server on it.

## Prerequisites
- AWS account access
- Basic knowledge of SSH

## Procedure

### 1. Launch the EC2 Instance
- Launched a **t2.micro** instance using the **Amazon Linux 2** AMI (free-tier eligible)
- Configured a security group to allow inbound traffic on:
  - **Port 22** (SSH)
  - **Port 80** (HTTP)
- Created and downloaded a key pair (`.pem` file) for secure SSH access

### 2. Connect to the Instance
Connected from a local terminal using SSH and the downloaded key pair:

```bash
ssh -i my-ec2-key.pem ec2-user@<Public-IP>
```

Verified a successful login at the instance's shell prompt.

### 3. Configure the Web Server
Updated system packages and installed the Apache HTTP server:

```bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
```

- Started the `httpd` service and enabled it to auto-start on reboot
- Verified the setup by browsing to the instance's Public IP — the default Apache test page loaded successfully

## Contents of this Directory
| File | Description |
|---|---|
| `Lab-01-EC2-Instance-Deployment.pdf` | Completed lab report with screenshots and step-by-step walkthrough |
| `Practice_-_1.pdf` | Reference lab instructions / practice sheet |
| `README.md` | This file |

## References
- [AWS EC2 User Guide — Concepts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [GeeksforGeeks — What is Elastic Compute Cloud (EC2)?](https://www.geeksforgeeks.org/what-is-elastic-compute-cloud-ec2/)
- [AWS EC2 — Getting Started](https://aws.amazon.com/ec2/getting-started/)

## Outcome
Successfully deployed and connected to an EC2 instance, configured Apache (`httpd`) as a web server, and confirmed it was reachable and serving the default page over HTTP via the instance's public IP.