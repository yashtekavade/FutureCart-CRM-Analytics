#!/bin/bash

# Step 1: Create HDFS directories
sudo -u hdfs hdfs dfs -mkdir -p /data/historical/cases
sudo -u hdfs hdfs dfs -mkdir -p /data/historical/surveys

# Step 2: Change ownership so your user can access
sudo -u hdfs hdfs dfs -chown -R ec2-user:ec2-user /data/historical

# Step 3: Upload JSON files to HDFS
hdfs dfs -put -f historical_data_jsonl/cases/*.json /data/historical/cases/
hdfs dfs -put -f historical_data_jsonl/surveys/*.json /data/historical/surveys/
