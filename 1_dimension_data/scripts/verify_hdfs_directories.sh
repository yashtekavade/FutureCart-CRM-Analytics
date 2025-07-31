#!/bin/bash
# Verify HDFS directories and create user directory if needed

hdfs dfs -ls

hdfs dfs -mkdir -p /user/ec2-user

hdfs dfs -chown ec2-user /user/ec2-user

echo "Launching Hive CLI..."

hive <<EOF
CREATE DATABASE IF NOT EXISTS dimension;
SHOW DATABASES;
USE dimension;
EXIT;
EOF
