#!/bin/bash

# Step 2.1: Create Kinesis Stream
# (This is usually done from AWS Console or CLI)

# Using AWS CLI to create stream with 1 shard
aws kinesis create-stream --stream-name case-survey-stream --shard-count 1 --region ap-south-1

echo "✅ Kinesis stream 'case-survey-stream' created with 1 shard."
