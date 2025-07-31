from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col, expr
from pyspark.sql.types import StructType, StringType, IntegerType

# Initialize Spark Session
spark = SparkSession.builder.appName("KinesisToRedshift").getOrCreate()
spark.sparkContext.setLogLevel("ERROR")

# Define schema for cases
case_schema = StructType() \
    .add("case_no", StringType()) \
    .add("create_timestamp", StringType()) \
    .add("last_modified_timestamp", StringType()) \
    .add("created_employee_key", StringType()) \
    .add("call_center_id", StringType()) \
    .add("status", StringType()) \
    .add("category", StringType()) \
    .add("sub_category", StringType()) \
    .add("communication_mode", StringType()) \
    .add("country_cd", StringType()) \
    .add("product_code", StringType())

# Define schema for surveys
survey_schema = StructType() \
    .add("survey_id", StringType()) \
    .add("case_no", StringType()) \
    .add("survey_timestamp", StringType()) \
    .add("Q1", IntegerType()) \
    .add("Q2", StringType()) \
    .add("Q3", IntegerType()) \
    .add("Q4", StringType()) \
    .add("Q5", IntegerType())

# Read from Kinesis stream
raw_stream = spark.readStream \
    .format("aws-kinesis") \
    .option("kinesis.region", "ap-south-1") \
    .option("kinesis.streamName", "futurekart-ravi") \
    .option("kinesis.consumerType", "GetRecords") \
    .option("kinesis.endpointUrl", "https://kinesis.ap-south-1.amazonaws.com") \
    .option("kinesis.startingposition", "LATEST") \
    .load()

# Extract JSON string from Kinesis data
json_str_df = raw_stream.selectExpr("CAST(data AS STRING) as json_data")

# Filter surveys and parse JSON
survey_df = json_str_df \
    .filter(expr("json_data LIKE '%survey_id%'")) \
    .withColumn("parsed", from_json(col("json_data"), survey_schema)) \
    .select("parsed.*")

# Filter cases and parse JSON
case_df = json_str_df \
    .filter(expr("NOT json_data LIKE '%survey_id%'")) \
    .withColumn("parsed", from_json(col("json_data"), case_schema)) \
    .select("parsed.*")

# Redshift connection details (customize as needed)
redshift_jdbc_url = "jdbc:redshift://ravi-wg.008673239246.ap-south-1.redshift-serverless.amazonaws.com:5439/dev"
redshift_user = "admin"
redshift_password = "Test1234"
temp_s3_dir = "s3://mysnowflakebucket-ravi/redshift-temp/"

def write_to_redshift(df, batch_id, table_name, tempdir):
    if df.rdd.isEmpty():
        return
    print(f"Writing batch of size {df.count()} to {table_name}")
    df.write \
        .format("io.github.spark_redshift_community.spark.redshift") \
        .option("url", f"{redshift_jdbc_url}?user={redshift_user}&password={redshift_password}") \
        .option("dbtable", table_name) \
        .option("tempdir", temp_s3_dir) \
        .option("aws_iam_role", "arn:aws:iam::008673239246:role/Redshift-S3Role-Ravi") \
        .mode("append") \
        .save()

# Stream write for case data
case_query = case_df.writeStream \
    .foreachBatch(lambda df, id: write_to_redshift(df, id, "public.case_table", temp_s3_dir)) \
    .start()

# Stream write for survey data
survey_query = survey_df.writeStream \
    .foreachBatch(lambda df, id: write_to_redshift(df, id, "public.survey_table", temp_s3_dir)) \
    .start()

spark.streams.awaitAnyTermination()
