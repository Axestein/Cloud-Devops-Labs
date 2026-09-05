# Lab 04 — Monitor AWS Resources Using CloudWatch

**Author:** Aditya Kumar Singh

## Objective
- Set up CloudWatch to monitor metrics and logs
- Create alarms for proactive monitoring

## Introduction
Amazon CloudWatch is a monitoring and observability service that collects metrics, logs, and events from AWS resources and applications, enabling teams to track performance and respond to operational issues in real time. It supports customizable alarms, log analysis, and dashboards for a unified view of system health. This experiment demonstrates enabling EC2 monitoring, creating alarms for CPU utilization, installing the CloudWatch Agent for custom metrics and log collection, and visualizing resource data through a dashboard.

## Prerequisites
- An active EC2 instance

## Procedure

### 1. Enable Monitoring for EC2
Navigated to the EC2 **Monitoring** tab and verified basic metrics — CPU utilization, network activity — at 5-minute granularity.

### 2. Create a CloudWatch Alarm
- Created a CloudWatch alarm (`High-CPU-Usage-Alarm`) for **EC2 CPU Utilization**, triggering when usage exceeds **70%**
- Evaluation period: **2 out of 3 datapoints** within 15 minutes
- Configured an **SNS topic** for email notifications on alarm state changes

### 3. Install CloudWatch Agent and Analyze Logs
Installed the CloudWatch Agent on the EC2 instance:

```bash
sudo yum install amazon-cloudwatch-agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
sudo systemctl start amazon-cloudwatch-agent
```

- Ran the configuration wizard to collect custom metrics (memory, disk usage) and stream system logs
- Viewed system logs (`/var/log/messages` and `/var/log/secure`) in the **CloudWatch Logs** section under the configured log groups

### 4. Create CloudWatch Dashboard
Created a custom dashboard (`Aditya-EC2-Monitoring`) with line chart widgets displaying:
- CPU utilization
- Memory usage percentage
- Disk usage metrics

## Contents of this Directory
| File | Description |
|---|---|
| `Lab-04-CloudWatch-Monitoring.pdf` | Completed lab report with screenshots and step-by-step walkthrough |
| `Practice_-_4.pdf` | Reference lab instructions / practice sheet |
| `README.md` | This file |

## References
- [Amazon CloudWatch — What Is Amazon CloudWatch?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)
- [GeeksforGeeks — Introduction to Amazon CloudWatch](https://www.geeksforgeeks.org/introduction-to-amazon-cloudwatch/)
- [Simplilearn — What is Amazon CloudWatch](https://www.simplilearn.com/tutorials/aws-tutorial/what-is-amazon-cloudwatch)

## Outcome
Successfully enabled EC2 monitoring, configured a CPU utilization alarm with SNS email notifications, installed the CloudWatch Agent to stream custom metrics and system logs, and built a custom dashboard visualizing CPU, memory, and disk metrics in real time.