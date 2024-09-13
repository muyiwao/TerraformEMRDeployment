resource "aws_emr_cluster" "spark_cluster" {
  name          = "EMR-Spark-Cluster"
  release_label = "emr-6.2.0"
  applications  = ["Spark"]
  log_uri       = var.log_uri

  ec2_attributes {
    subnet_id                         = var.subnet_id
    instance_profile                  = var.instance_profile
    emr_managed_master_security_group = var.master_security_group
    emr_managed_slave_security_group  = var.slave_security_group
  }

  master_instance_group {
    instance_type  = "m4.large"
    instance_count = 1
  }

  core_instance_group {
    instance_type  = "m4.large"
    instance_count = 2
  }

  service_role = var.service_role

  configurations_json = file("${path.module}/configurations.json")

  step {
    name              = "Setup - Debugging"
    action_on_failure = "TERMINATE_CLUSTER"
    hadoop_jar_step {
      jar  = "command-runner.jar"
      args = ["state-pusher-script"]
    }
  }

  step {
    name              = "Run PySpark Job"
    action_on_failure = "CONTINUE"
    hadoop_jar_step {
      jar  = "command-runner.jar"
      //args = ["spark-submit", "--deploy-mode", "cluster", var.pyspark_script_path]
      args = ["spark-submit", "--deploy-mode", "cluster", "s3://terraform-emr-spark-bucket/scripts/spark_job.py"]
      //args = ["spark-submit", "--deploy-mode", "cluster", "--conf", "spark.yarn.jars=s3://my-spark-libs-env/spark/libs/*", var.pyspark_script_path]
    }
  }
}

