#!/bin/bash

HOST="172.31.8.1"
DB="futurecart_crm"
USER="root"
PASSWORD="tekavade123"
HIVE_DB="dimension"

tables=(
  futurecart_calendar_details
  futurecart_call_center_details
  futurecart_case_category_details
  futurecart_case_country_details
  futurecart_case_priority_details
  futurecart_employee_details
  futurecart_product_details
  futurecart_survey_question_details
)

for table in "${tables[@]}"
do
  echo "Importing $table via Sqoop..."
  sqoop import \
    --connect jdbc:mysql://$HOST:3306/$DB \
    --username $USER \
    --password $PASSWORD \
    --table $table \
    --hive-import \
    --hive-database $HIVE_DB \
    --hive-table $table \
    --create-hive-table \
    --fields-terminated-by '\t' \
    -m 1 \
    --driver org.mariadb.jdbc.Driver
done
