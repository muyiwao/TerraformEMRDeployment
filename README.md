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


// aws s3 mb s3://terraform-emr-state-bucket --region eu-west-2
// aws dynamodb create-table --table-name terraform-emr-lock-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region eu-west-2





