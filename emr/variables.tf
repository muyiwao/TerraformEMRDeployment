variable "subnet_id" {
  description = "Subnet ID where the EMR cluster will be created"
}

variable "instance_profile" {
  description = "Instance profile for EMR EC2 instances"
}

variable "master_security_group" {
  description = "Security group for EMR master instances"
}

variable "slave_security_group" {
  description = "Security group for EMR slave instances"
}

variable "service_role" {
  description = "IAM service role for EMR"
}

variable "log_uri" {
  description = "S3 URI for storing EMR logs"
  type        = string
}

variable "pyspark_script_path" {
  description = "S3 path to the PySpark script"
  type        = string
}
