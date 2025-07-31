Dimension Data Flow Documentation
1. Overview
This document describes the data flow for the dimension data in the futurecart_crm database. It covers the process of data ingestion, transformation, storage, and consumption of dimension tables used for analytics and reporting.

2. Source Data
Raw dimension data files are stored under 1_dimension_data/sample_data/.

These files include details like calendar, call center, case categories, countries, priorities, employee info, products, and survey questions.

Data files are in text format, with fields separated by spaces.

3. Database Setup
MariaDB 10.5 is installed on the EC2 instance.

The database futurecart_crm is created to hold the dimension tables.

Table schemas are defined as per mariadb_database_setup.sql.

4. Data Loading Process
MariaDB is configured to allow loading data from local files (local_infile=1).

Data is loaded into MariaDB tables using LOAD DATA LOCAL INFILE commands for each dimension file.

Each table corresponds to a dimension data file.

5. Verification & Validation
After loading, basic data validation queries are run to ensure data completeness.

HDFS directory structure is checked and created if needed.

Hive database dimension is created for downstream processing.

6. Data Import to Hive via Sqoop
Sqoop imports the data from MariaDB to Hive.

Each dimension table is imported individually.

Data is stored in the Hive database dimension.

Sqoop commands are scripted in sqoop_import_all_tables.sh.

7. Exporting Data to S3
Dimension tables from Hive are exported to S3 as Parquet files for analytics consumption.

This is done using a Spark job scripted in export_hive_to_s3.py.

The output path is s3://tbsm-destination/db/.

8. Automation & Scripts
Installation, setup, and data import scripts are located under 1_dimension_data/scripts/.

Key scripts:

mariadb_installation_ec2.sh — MariaDB installation and setup.

verify_hdfs_directories.sh — Checks HDFS directories and Hive DB.

sqoop_import_all_tables.sh — Sqoop import commands.

export_hive_to_s3.py — Spark job exporting Hive tables to S3.

