variable "pyspark_scripts_bucket" {
  description = "The S3 bucket name for PySpark scripts."
  type        = string
}

variable "emr_logs_bucket" {
  description = "The S3 bucket name for EMR logs."
  type        = string
}

variable "spark_libraries_bucket" {
  description = "The S3 bucket name for Spark Libraries."
  type        = string
}