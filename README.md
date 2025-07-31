# FutureCart CRM Analytics

## What This Does
Real-time customer service analytics using AWS services.

## Architecture
Kinesis → EMR (Spark/Hive) → Redshift → QuickSight

## Quick Setup
1. `pip install -r requirements.txt`
2. Run scripts in order: `1_setup_aws.sh`, `2_create_kinesis.sh`, etc.
3. Follow `docs/setup_guide.md`

## Project Parts
- **Part 1**: Extract → Landing (Kinesis, S3, EMR)
- **Part 2**: Landing → Transform (Spark jobs)  
- **Part 3**: Transform → Load (Redshift)
