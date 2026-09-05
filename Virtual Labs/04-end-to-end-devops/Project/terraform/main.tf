provider "aws" {
  region = "us-east-1"
}

# Security Group for SSH and HTTP
resource "aws_security_group" "devops_sg" {
  name_prefix = "devops-sg-"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "devops_server" {
  ami             = "ami-0c02fb55956c7d316"  # Ubuntu 20.04 LTS
  instance_type   = "t2.micro"
  key_name        = "my-key"  # Replace with your key pair name
  
  security_groups = [aws_security_group.devops_sg.name]
  
  tags = {
    Name = "DevOps-Lab-Server"
    Environment = "DevOps"
  }
  
  # User data to install Docker and dependencies
  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    usermod -aG docker ubuntu
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/
  EOF
}

output "instance_public_ip" {
  value = aws_instance.devops_server.public_ip
}

output "instance_public_dns" {
  value = aws_instance.devops_server.public_dns
}