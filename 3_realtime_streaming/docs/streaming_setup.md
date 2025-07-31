## 🔧 Prerequisites
- EC2 Instance with boto3 and Kinesis permissions
- EMR Cluster with Spark installed
- Redshift Serverless Workgroup created and publicly accessible
- IAM Role with Redshift and Kinesis access

---

## ✅ Step 1: Launch EC2 for Data Generation

### 1.1 Launch EC2 Instance
- Amazon Linux 2 AMI
- Attach IAM Role with Kinesis write access

### 1.2 Install packages on EC2
```bash
sudo yum update -y
pip3 install boto3
1.3 Upload 000000_0 and stream_to_kinesis.py to EC2
Use scp or AWS Console

1.4 Edit stream_to_kinesis.py
Ensure:

stream_name = 'case-survey-stream'

region_name = 'ap-south-1'

1.5 Run the generator

python3 stream_to_kinesis.py
This continuously sends random case/survey JSON records to your Kinesis stream.

✅ Step 2: Kinesis Setup
2.1 Create Stream
AWS Console > Kinesis > Data Streams

Stream name: case-survey-stream

1 shard

Or run:


aws kinesis create-stream --stream-name case-survey-stream --shard-count 1 --region ap-south-1
✅ Step 3: EMR Setup with Spark
3.1 Launch EMR Cluster
Amazon EMR 6.x

Applications: Spark, Hadoop

Instance type: m5.xlarge (or t3.medium for testing)

Place in same VPC as Redshift

Security Group allows outbound on port 5439 (Redshift)

3.2 SSH into EMR Master Node

ssh -i your-key.pem hadoop@<EMR-MASTER-PUBLIC-IP>
3.3 Upload Spark Streaming script kinesis_to_redshift.py
3.4 Submit the Spark Job

spark-submit \
  --packages "com.amazon.redshift:redshift-jdbc42:2.1.0.9" \
  kinesis_to_redshift.py
✅ Step 4: Redshift Setup
4.1 Create Tables in Redshift

CREATE TABLE case_table (
  case_no VARCHAR,
  status VARCHAR,
  category VARCHAR,
  sub_category VARCHAR,
  last_modified_timestamp VARCHAR,
  create_timestamp VARCHAR,
  created_employee_key VARCHAR,
  call_center_id VARCHAR,
  product_code VARCHAR,
  country_cd VARCHAR,
  communication_mode VARCHAR
);

CREATE TABLE survey_table (
  survey_id VARCHAR,
  case_no VARCHAR,
  survey_timestamp VARCHAR,
  Q1 INT,
  Q2 INT,
  Q3 INT,
  Q4 VARCHAR,
  Q5 INT
);
4.2 Confirm Streaming Ingestion
After running Spark job for ~1 min, run:


SELECT * FROM case_table ORDER BY create_timestamp DESC LIMIT 10;
SELECT * FROM survey_table ORDER BY survey_timestamp DESC LIMIT 10;
