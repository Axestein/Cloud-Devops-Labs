# Lab 02 — Create and Manage an S3 Bucket

**Author:** Aditya Kumar Singh

## Objective
- Create an S3 bucket and upload, manage, and retrieve files

## Introduction
Amazon Simple Storage Service (S3) is a highly scalable, durable object storage service used to store and retrieve any amount of data from anywhere on the web. It supports fine-grained access control, versioning, and automated data lifecycle management, making it a foundational service for cloud storage. This experiment demonstrates creating an S3 bucket, uploading and managing files with versioning and lifecycle policies, and retrieving data using the AWS CLI.

## Prerequisites
- AWS account access

## Procedure

### 1. Create S3 Bucket
- Created a uniquely named bucket (`aditya-devops916-test-bucket`) using default settings
- Ensured **public access was blocked** to keep the bucket secure by default

### 2. Upload Files
- Uploaded a test file (`my-first-file.txt`) to the bucket with default permissions

### 3. Manage Files
- Enabled **versioning** on the bucket, to preserve, retrieve, and restore every version of every object
- Created a **lifecycle rule** (`move-to-glacier`) to transition objects to **S3 Glacier Flexible Retrieval** after 30 days

### 4. Retrieve Files
Installed and configured the AWS CLI:

```bash
aws configure
```

Downloaded a file from the bucket using the CLI:

```bash
aws s3 cp s3://<bucket-name>/my-first-file.txt ./downloaded-file.txt
```

- Verified the downloaded file's content in the terminal

## Contents of this Directory
| File | Description |
|---|---|
| `Lab-02-S3-Bucket-Management.pdf` | Completed lab report with screenshots and step-by-step walkthrough |
| `Practice_-_2.pdf` | Reference lab instructions / practice sheet |
| `README.md` | This file |

## 📖 References
- [Amazon S3 User Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [GeeksforGeeks — Introduction to AWS S3](https://www.geeksforgeeks.org/introduction-to-aws-simple-storage-service-awss3/)
- [Simplilearn — AWS S3 Tutorial](https://www.simplilearn.com/tutorials/aws-tutorial/aws-s3)

## 🎯 Outcome
Successfully created a secure, private S3 bucket, uploaded and versioned objects, configured a lifecycle rule to archive data to Glacier, and retrieved a file back to a local machine using the AWS CLI.