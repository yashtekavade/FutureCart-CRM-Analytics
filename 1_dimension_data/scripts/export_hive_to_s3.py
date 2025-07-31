from pyspark.sql import SparkSession

def export_table(spark, hive_db, table_name, s3_path):
    full_table_name = f"{hive_db}.{table_name}"
    print(f"Exporting {full_table_name} to {s3_path} ...")

    df = spark.table(full_table_name)

    df.write.mode("overwrite").parquet(s3_path)

    print(f"Done exporting {full_table_name}")

def main():
    spark = SparkSession.builder \
        .appName("HiveToS3Export") \
        .enableHiveSupport() \
        .getOrCreate()

    hive_db = "dimension"
    s3_base_path = "s3://tbsm-destination/db/"

    tables = [
        "futurecart_calendar_details",
        "futurecart_call_center_details",
        "futurecart_case_category_details",
        "futurecart_case_country_details",
        "futurecart_case_priority_details",
        "futurecart_employee_details",
        "futurecart_product_details",
        "futurecart_survey_question_details"
    ]

    for table in tables:
        s3_path = f"{s3_base_path}{table}"
        export_table(spark, hive_db, table, s3_path)

    spark.stop()

if __name__ == "__main__":
    main()


# Run with:

# bash
# Copy code
# spark-submit export_hive_tables_to_s3.py
