#!/usr/bin/env python
import boto3
import os
os.environ['AWS_DEFAULT_REGION'] = ''
os.environ['AWS_ACCESS_KEY_ID'] = ''
os.environ['AWS_SECRET_ACCESS_KEY'] = ''

client = boto3.client('rds')
instances = client.describe_db_instances(DBInstanceIdentifier='footgo')
rds_host = instances.get('DBInstances')[0].get('Endpoint').get('Address')
print(rds_host)

