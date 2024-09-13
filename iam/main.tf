resource "aws_iam_role" "emr_service_role" {
  name = "emr_service_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = { Service = "elasticmapreduce.amazonaws.com" },
      Effect    = "Allow",
    }]
  })
}

resource "aws_iam_role_policy_attachment" "emr_service_role_policy" {
  role       = aws_iam_role.emr_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

resource "aws_iam_role" "emr_ec2_role" {
  name = "emr_ec2_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = { Service = "ec2.amazonaws.com" },
      Effect    = "Allow",
    }]
  })
}

resource "aws_iam_instance_profile" "emr_ec2_instance_profile" {
  name = "emr_ec2_instance_profile"
  role = aws_iam_role.emr_ec2_role.name
}

data "aws_iam_policy_document" "emr_s3_access_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${var.pyspark_scripts_bucket}/*",
      "arn:aws:s3:::${var.emr_logs_bucket}/*",
      "arn:aws:s3:::${var.spark_libraries_bucket}",
      "arn:aws:s3:::${var.spark_libraries_bucket}/*",
      "arn:aws:s3:::terraform-emr-spark-bucket",
      "arn:aws:s3:::terraform-emr-spark-bucket/*"
    ]
  }
}

resource "aws_iam_policy" "emr_s3_access_policy" {
  name        = "emr_s3_access_policy"
  path        = "/"
  description = "Allows EMR EC2 role access to specific S3 buckets"

  policy = data.aws_iam_policy_document.emr_s3_access_policy.json
}

resource "aws_iam_policy_attachment" "emr_s3_access_attach" {
  name       = "emr-s3-access-attachment"
  roles      = [aws_iam_role.emr_ec2_role.id]  # Corrected to 'roles' and provided as a list
  policy_arn = aws_iam_policy.emr_s3_access_policy.arn
}


