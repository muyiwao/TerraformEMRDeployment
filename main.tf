// main.tf

// S3 backend
terraform {
  backend "s3" {
    bucket         = "terraform-emr-state-bucket" # bucket name
    key            = "terraform/state"            # Path in the bucket
    region         = "eu-west-2"                  # S3 Bucket region
    dynamodb_table = "terraform-emr-lock-table"    # DynamoDB table for state locking
    encrypt        = true                         # Enable encryption
  }
}


module "network" {
  source            = "./network"
  availability_zone = var.availability_zone
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
}

module "s3" {
  source = "./s3"
}

module "iam" {
  source                  = "./iam"
  pyspark_scripts_bucket  = module.s3.pyspark_scripts_bucket
  emr_logs_bucket         = module.s3.emr_logs_bucket
  spark_libraries_bucket  = module.s3.spark_libraries_bucket
}



module "security_groups" {
  source = "./security_groups"
  vpc_id = module.network.vpc_id // Passing the dynamically created VPC ID
}

module "emr" {
  source                = "./emr"
  subnet_id             = module.network.subnet_id
  master_security_group = module.security_groups.master_security_group_id
  slave_security_group  = module.security_groups.slave_security_group_id
  instance_profile      = module.iam.instance_profile_name
  service_role          = module.iam.service_role_name
  log_uri               = "s3://${module.s3.emr_logs_bucket}/emr-logs/"
  //pyspark_script_path   = "s3://${module.s3.pyspark_scripts_bucket}/spark_job.py"
  //spark_libraries_path  = "s3://${module.s3.spark_libraries_bucket}/"
}

  //log_uri               = "s3://${module.s3.emr_logs.id}/emr-logs/"
  //pyspark_script_path   = "s3://${module.s3.pyspark_scripts.id}/spark_job.py"