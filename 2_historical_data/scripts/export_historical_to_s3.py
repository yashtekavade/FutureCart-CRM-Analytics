from pyspark.sql import SparkSession

def main():
    spark = SparkSession.builder \
        .appName("ExportHistoricalToS3") \
        .enableHiveSupport() \
        .getOrCreate()

    tables = {
        "case_details": "s3://tbsm-core/historical/case/",
        "case_survey_details": "s3://tbsm-core/historical/survey/"
    }

    for table, path in tables.items():
        print(f"Exporting {table} to {path} ...")
        df = spark.sql(f"SELECT * FROM {table}")
        df.write.mode("overwrite").parquet(path)
        print(f"Exported {table} successfully.")

    spark.stop()

if __name__ == "__main__":
    main()


# To run the Spark export job:

# bash
# Copy code
# spark-submit export_historical_to_s3.py