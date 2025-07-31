# Step 4.1 Enable Local Infile in /etc/my.cnf (add under [mysqld])
# local_infile=1

sudo systemctl restart mariadb

# Login as root
sudo mysql -u root -p

# Check if local_infile enabled
SHOW VARIABLES LIKE 'local_infile';

# If OFF, enable it dynamically:
SET GLOBAL local_infile = 1;

USE futurecart_crm;

# Load data (example for calendar details)
LOAD DATA LOCAL INFILE '/home/ec2-user/futurecart_calendar_details.txt'
INTO TABLE futurecart_calendar_details
FIELDS TERMINATED BY ' '
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# Repeat LOAD DATA LOCAL INFILE for other tables, just change the file/table names.
