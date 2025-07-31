Sure! Here’s a polished, professional **README.md** for your **futurecart-crm-analytics** project, covering the structure and step-by-step instructions clearly.

---

```markdown
# FutureCart CRM Analytics Pipeline

## Overview

This project implements an end-to-end CRM analytics pipeline for FutureCart, handling both batch and real-time data processing. It covers dimension data setup, historical data simulation, real-time streaming ingestion, and analytics using AWS services including EC2, Kinesis, Hive, Spark, Redshift, and QuickSight.

---

## Repository Structure

```

futurecart-crm-analytics/
├── 1\_dimension\_data/          # Setup and scripts for dimension data in MySQL, Hive, and S3
├── 2\_historical\_data/         # Scripts to generate and ingest historical case and survey data
├── 3\_realtime\_streaming/      # Real-time streaming simulation and ingestion via Kinesis and Spark
├── 4\_redshift\_warehouse/      # Redshift table creation, data loading, and analytics SQL queries
├── config/                   # Configuration files (e.g., config.yaml)
├── requirements.txt           # Python dependencies
├── README.md                  # This documentation file
└── .gitignore                 # Git ignore rules

```

---

## Step-by-Step Setup and Execution

### Step 1: Dimension Data Setup

- Prepare `.txt` files for 8 dimension datasets (e.g., calendar, call center, product details).
- Launch MySQL/MariaDB on an EC2 instance.
- Run `mariadb_database_setup.sql` to create dimension tables.
- Load `.txt` files into MySQL using `LOAD DATA INFILE`.
- Verify data load using scripts like `verify_hdfs_directories.sh`.

### Step 2: Batch Ingestion

- Use Sqoop (`sqoop_import_all_tables.sh`) to import MySQL dimension tables into Hive.
- Export Hive tables to S3 as Parquet files using `export_hive_to_s3.py`.
- Load S3 data into Redshift using COPY commands (`load_dimension_data.sql`).

### Step 3: Historical Data Setup

- Generate 10 days of historical case and survey JSON data using `generate_historical_data.py`.
- Upload JSON files to HDFS (`upload_json_to_hdfs.sh`).
- Create Hive external tables for historical data using `hive_database_table_setup.hql`.
- Export Hive tables to S3 and load into Redshift for analysis.

### Step 4: Real-Time Data Simulation

- Use `stream_to_kinesis.py` to simulate and stream real-time case and survey events.
- Data is streamed into two Kinesis streams:
  - `futurecart_case_event`
  - `futurecart_survey_event`

### Step 5: Real-Time Processing

- Deploy a Spark Streaming consumer (`kinesis_to_redshift.py`) on EMR or similar to:
  - Read from Kinesis streams.
  - Parse incoming JSON events.
  - Insert case data into Redshift case tables.
  - Insert survey data into Redshift survey tables.

### Step 6: Data Export and Load

- Export transformed Hive data to S3 using Spark DataFrames.
- Load the exported data from S3 into Redshift using COPY commands or AWS Glue.

### Step 7: KPI Queries

- Run KPI SQL queries (`kpi_queries.sql`, `analytical_queries_12.sql`) on Redshift to analyze:
  - Case volumes and status.
  - SLA compliance metrics.
  - Survey sentiment scoring.

### Step 8: Visualization

- Connect Amazon QuickSight to Redshift.
- Build interactive dashboards visualizing CRM KPIs and trends.

---

## Prerequisites

- AWS account with permissions for EC2, Kinesis, EMR, Redshift, S3, and QuickSight.
- Python 3.x with required libraries (see `requirements.txt`).
- MySQL/MariaDB server for dimension data.
- Hadoop/Hive environment for batch processing.
- Proper IAM roles and network setup to enable service integration.

---

## Getting Started

1. Follow the docs in each module (`docs/` folders) for detailed setup instructions.
2. Execute scripts in the order described above.
3. Monitor data flows at each stage for successful ingestion and processing.
4. Customize SQL queries and dashboards based on your analytics needs.

---

## Helpful Scripts & Files

- `1_dimension_data/scripts/`: Sqoop imports, HDFS verification, Hive exports.
- `2_historical_data/scripts/`: Historical data generation and ingestion.
- `3_realtime_streaming/scripts/`: Kinesis data streaming and Spark consumer.
- `4_redshift_warehouse/sql/`: Table creation and data loading SQL.
- `4_redshift_warehouse/analytics/`: SQL queries for reporting.
- `4_redshift_warehouse/scripts/execute_all_queries.py`: Automate query execution.

---

## Contact & Support

For questions or support, please reach out to the FutureCart data engineering team or open an issue on this repository.

---

**Build smart, analyze fast, deliver insights effectively!** 🚀
```

---

Would you like me to help with any specific module docs or script comments next?
