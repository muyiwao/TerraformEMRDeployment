output "pyspark_scripts_bucket" {
  value = aws_s3_bucket.pyspark_scripts.bucket
}

output "emr_logs_bucket" {
  value = aws_s3_bucket.emr_logs.bucket
}