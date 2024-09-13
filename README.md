# Terraform EMR Deployment

## Overview
This project to launch EMR using terraform to process spark job 


## Setup
###  Create these resources using the AWS CL
```bash
aws s3 mb s3://terraform-emr-state-bucket --region eu-west-2
```
```bash
aws dynamodb create-table --table-name terraform-emr-lock-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region eu-west-2
```

## Project Structure
```bash
TerraformEMRDeploy/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── spark_job.py
│
├── network/                  
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── security_groups/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── iam/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
└── emr/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── configurations.json
│  
└── /spark-libs
    └── [library files]

```

## Additional commands
Manually Release the State Lock
If you are sure no other operations are currently running, you can manually release the state lock using the following Terraform command:
```bash
terraform force-unlock 5add0e3a-fd45-0717-749a-4d8772724f7c
```
This is useful if  Terraform was unable to acquire a lock on the state file because another operation might be currently using it or a previous operation did not release the lock properly. This is a common issue when multiple users or systems might be interacting with the same Terraform state or if an operation was interrupted unexpectedly.