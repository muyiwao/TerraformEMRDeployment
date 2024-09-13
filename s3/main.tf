resource "aws_s3_bucket" "emr_logs" {
  bucket_prefix = "emr-logs-"

  tags = {
    Purpose = "EMR Logs"
  }
}

resource "aws_s3_bucket" "spark_libs" {
  bucket = "my-spark-libs-env"

  tags = {
    Name        = "Spark Libraries"
  }
}

// resource "aws_s3_bucket_acl" "spark_libs_acl" {
//  bucket = aws_s3_bucket.spark_libs.id
//  acl    = "private"
//}

resource "aws_s3_bucket_versioning" "spark_libs_versioning" {
  bucket = aws_s3_bucket.spark_libs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "spark_libraries" {
  for_each = fileset("${path.module}/../../spark-libs", "**/*")
  bucket   = aws_s3_bucket.spark_libs.id
  key      = "spark/libs/${each.value}"
  source   = "${path.module}/../../spark-libs/${each.value}"
  etag     = filemd5("${path.module}/../../spark-libs/${each.value}")
}

resource "aws_s3_bucket" "pyspark_scripts" {
  bucket_prefix = "pyspark-scripts-"

  tags = {
    Purpose = "PySpark Scripts"
  }
}

resource "aws_s3_object" "pyspark_script" {
  bucket = aws_s3_bucket.pyspark_scripts.id
  key    = "spark_job.py"
  source = "${path.module}/../spark_job.py"

  etag = filemd5("${path.module}/../spark_job.py")

  tags = {
    FileChecksum = filemd5("${path.module}/../spark_job.py")
  }
}




