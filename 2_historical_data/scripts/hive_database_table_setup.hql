-- Step 1: Create database (optional if already created)
CREATE DATABASE IF NOT EXISTS historical_data;
USE historical_data;

-- Step 2: Create external table for case details
CREATE EXTERNAL TABLE case_details (
    status STRING,
    category STRING,
    sub_category STRING,
    last_modified_timestamp STRING,
    case_no STRING,
    create_timestamp STRING,
    created_employee_key STRING,
    call_center_id STRING,
    product_code STRING,
    country_cd STRING,
    communication_mode STRING
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '/data/historical/cases';

-- Step 3: Create external table for survey details
CREATE EXTERNAL TABLE case_survey_details (
    survey_id STRING,
    case_no STRING,
    survey_timestamp STRING,
    Q1 INT,
    Q2 INT,
    Q3 INT,
    Q4 STRING,
    Q5 INT
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '/data/historical/surveys';

-- Step 4: Verify data load counts
SELECT COUNT(*) FROM case_details;
SELECT COUNT(*) FROM case_survey_details;
