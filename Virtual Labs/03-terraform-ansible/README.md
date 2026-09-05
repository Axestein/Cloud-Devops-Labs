# VLE 03 — Creating a VPC with Terraform and Configuring EC2 with Ansible

**Author:** Aditya Kumar Singh 

## Aim
To create an AWS Virtual Private Cloud (VPC) using **Terraform** and configure EC2 instances automatically using **Ansible**.

## Scenario
An organization wants to deploy applications on AWS with minimal manual work. They require:
- A custom VPC
- A public subnet with internet access
- EC2 instances
- Automated server configuration

Terraform is used for infrastructure creation, and Ansible is used for configuration management.

## Tools & Technologies
- AWS (EC2, VPC)
- Terraform
- Ansible
- Linux
- SSH

## Architecture
- One VPC
- One public subnet
- One Internet Gateway
- One route table
- Two EC2 instances
- Ansible configures the EC2 instances after they're created

## Procedure

### Part 1 — Infrastructure with Terraform

**Setup**
```bash
choco install terraform -y
choco install awscli -y
terraform --version
```

**Project structure**
```
terraform-ansible-project/
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── provider.tf
    └── outputs.tf
```

**Key resources defined in `main.tf`:**
- AWS provider (`region = "us-east-1"`)
- `aws_vpc.dev_vpc` — CIDR `10.0.0.0/16`
- `aws_subnet.public_subnet` — CIDR `10.0.1.0/24`, auto-assign public IP, AZ `us-east-1a`
- `aws_internet_gateway.igw`
- `aws_route_table.public_rt` — default route (`0.0.0.0/0`) via the IGW
- `aws_route_table_association.rt_assoc`
- `aws_security_group.sg` — allows inbound SSH (22), HTTP (80), and HTTPS
- `aws_instance.ec2` — `count = 2`, `t2.micro`, Amazon Linux AMI, keyed with `my-key`

**Deployment:**
```bash
terraform init
terraform plan
terraform apply
```

**Provisioned resources:**

| Resource | Details |
|---|---|
| VPC | `vpc-00206b93045677440` (`10.0.0.0/16`) |
| Public Subnet | `subnet-0a51cd56c3234baf3` (`10.0.1.0/24`) |
| Internet Gateway | `igw-08df818802b0e6b43` |
| Route Table | `rtb-090e18f20c54da610` |
| Security Group | `sg-0641baff674979b69` (allows SSH, HTTP, HTTPS) |
| EC2 Instance 1 | `i-08d99e179738f1db4` (IP: `3.82.4.117`) |
| EC2 Instance 2 | `i-0cfdb042ef6aa8d59` (IP: `54.81.1.214`) |

### Part 2 — Configuration with Ansible

**Install Ansible**
```bash
pip install ansible
```

**Inventory (`ansible/inventory.ini`)**
```ini
[servers]
server1 ansible_host=<EC2_PUBLIC_IP_1>
server2 ansible_host=<EC2_PUBLIC_IP_2>

[servers:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=my-key.pem
```

**Test connectivity**
```bash
ansible -i inventory.ini servers -m ping
```
Both `server1` and `server2` responded successfully (`"ping": "pong"`).

**Playbook (`install_docker.yml`)** — installs system packages, adds the Docker repo, installs Docker, starts/enables the Docker service, and adds `ec2-user` to the `docker` group.

**Run the playbook**
```bash
ansible-playbook -i inventory.ini install_docker.yml
```
- Confirmed Docker version installed on both servers (Docker 26.1.4)
- Created and verified a test Nginx container running on both instances (port `80 → 80`)
- Confirmed final success message: *"Docker and Nginx are successfully installed on app-server-1/2"*

**Final verification**
```bash
ansible -i inventory.ini servers -m command -a "docker ps"
```
Confirmed the `test-nginx` container running on both `server1` and `server2`.

## Result
- AWS VPC and EC2 instances were created using Terraform
- EC2 instances were configured automatically using Ansible
- Docker (and an Nginx test container) was installed and started successfully on both instances
- Applications accessible at:
  - Server 1: `http://3.82.4.117`
  - Server 2: `http://54.81.1.214`

## Conclusion
This experiment demonstrates how Terraform automates infrastructure creation and Ansible automates server configuration, following real-world Infrastructure-as-Code and configuration-management DevOps practices.

## Contents of this Directory
| File / Folder | Description |
|---|---|
| `VLE-03-Terraform-Ansible-AWS.pdf` | Completed lab report with terminal output and deployment screenshots |
| `Terraform-ansible-VPN.pdf` | Reference lab sheet — aim, scenario, architecture, and full procedure |
| `project/` | Terraform + Ansible project files (`terraform/*.tf`, `ansible/inventory.ini`, `ansible/install_docker.yml`, setup/cleanup scripts) |
| `README.md` | This file |