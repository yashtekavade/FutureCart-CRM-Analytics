-- Phase 2: Create Database and Tables

-- Step 2.1: Login with:
-- mysql -u root -p

CREATE DATABASE IF NOT EXISTS futurecart_crm;
USE futurecart_crm;

-- Create Tables

CREATE TABLE futurecart_calendar_details (
    calendar_date DATE,
    date_desc VARCHAR(50),
    week_day_nbr SMALLINT,
    week_number SMALLINT,
    week_name VARCHAR(50),
    year_week_number INT,
    month_number SMALLINT,
    month_name VARCHAR(50),
    quarter_number SMALLINT,
    quarter_name VARCHAR(50),
    half_year_number SMALLINT,
    half_year_name VARCHAR(50),
    geo_region_cd CHAR(2)
);

CREATE TABLE futurecart_call_center_details (
    call_center_id VARCHAR(10),
    call_center_vendor VARCHAR(50),
    location VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE futurecart_case_category_details (
    category_key VARCHAR(10),
    sub_category_key VARCHAR(10),
    category_description VARCHAR(50),
    sub_category_description VARCHAR(50),
    priority VARCHAR(10)
);

CREATE TABLE futurecart_case_country_details (
    id INT,
    name VARCHAR(75),
    alpha_2 VARCHAR(2),
    alpha_3 VARCHAR(3)
);

CREATE TABLE futurecart_case_priority_details (
    priority_key VARCHAR(5),
    priority VARCHAR(20),
    severity VARCHAR(100),
    sla VARCHAR(100)
);

CREATE TABLE futurecart_employee_details (
    emp_key INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    gender VARCHAR(10),
    ldap VARCHAR(50),
    hire_date DATE,
    manager VARCHAR(50)
);

CREATE TABLE futurecart_product_details (
    product_id VARCHAR(20),
    department VARCHAR(50),
    brand VARCHAR(50),
    commodity_desc VARCHAR(100),
    sub_commodity_desc VARCHAR(100)
);

CREATE TABLE futurecart_survey_question_details (
    question_id VARCHAR(10),
    question_desc VARCHAR(255),
    response_type VARCHAR(50),
    `range` VARCHAR(20),              
    negative_response_range VARCHAR(20),
    neutral_response_range VARCHAR(20),
    positive_response_range VARCHAR(20)
);
