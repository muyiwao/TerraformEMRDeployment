from pyspark.sql import SparkSession
import sys


def main():
    spark = SparkSession.builder.appName("SimpleApp").getOrCreate()

    try:
        # Load the data
        df = spark.read.csv("s3://terraform-emr-spark-bucket/input/data.csv", header=True, inferSchema=True)

        # Perform a simple transformation: Add a new column that doubles a numeric column
        df_transformed = df.withColumn("double_value", df["value"] * 2)

        # Show transformed data
        df_transformed.show()

        # Save the transformed data back to S3
        df_transformed.write.csv("s3://terraform-emr-spark-bucket/output/", mode="overwrite", header=True)

    except Exception as e:
        print(f"Error processing PySpark job: {str(e)}", file=sys.stderr)
        sys.exit(1)

    finally:
        spark.stop()


if __name__ == "__main__":
    main()
