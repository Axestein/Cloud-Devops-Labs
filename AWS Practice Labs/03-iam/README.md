# Lab 03 — Implement IAM for Secure Access

**Author:** Aditya Kumar Singh

## Objective
- Create an IAM user, group, and role
- Assign permissions and test access

## Introduction
AWS Identity and Access Management (IAM) lets you securely control access to AWS services and resources. This lab covers creating an IAM user and group, attaching managed policies, and (per the reference procedure) testing access via the CLI and assigning a role to an EC2 instance.

## Prerequisites
- AWS account access

## Procedure

### Task 1: Create an IAM User
Went to **IAM Dashboard > Users > Add User**, provided the username `s3-readonly-user`, selected **Programmatic Access**, and attached the `AmazonS3ReadOnlyAccess` managed policy.

### Task 2: Create an IAM Group
Navigated to **Groups > Create Group**, created the group `S3-ReadOnly-Group` (named `readonly` in console), added the user to it, and assigned the `AmazonS3ReadOnlyAccess` policy to the group. Confirmed the group was created and the user (`s3-readonly-user`) was added successfully.

### Task 3: Test Access *(per reference procedure)*
- Configure the AWS CLI with the user's access keys:
  ```bash
  aws configure
  ```
- Test read-only S3 access:
  ```bash
  aws s3 ls
  ```

### Task 4: Create and Assign an IAM Role *(per reference procedure)*
- Go to **Roles > Create Role**
- Attach a policy (e.g., `AmazonEC2FullAccess`)
- Assign the role to an EC2 instance

## Contents of this Directory
| File | Description |
|---|---|
| `Lab-03-IAM-Secure-Access.pdf` | Completed lab report with screenshots for user/group creation |
| `Practice_-_3__1_.pdf` | Reference lab instructions / practice sheet |
| `README.md` | This file |

## References
- [AWS IAM User Guide — Introduction](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
- [GeeksforGeeks — IAM in AWS](https://www.geeksforgeeks.org/identity-and-access-management-iam-in-amazonweb-services-aws/)
- [Simplilearn — AWS IAM Tutorial](https://www.simplilearn.com/tutorials/aws-tutorial/aws-iam)

## Outcome
Successfully created an IAM user with programmatic access, grouped it under a read-only group, and attached the `AmazonS3ReadOnlyAccess` policy — enforcing least-privilege access to S3 resources.