#!/usr/bin/env python
import boto3

client = boto3.client('rds')
instances = client.describe_db_instances(DBInstanceIdentifier='footgo')
rds_host = instances.get('DBInstances')[0].get('Endpoint').get('Address')
print(rds_host)


#client1 = boto3.client('elbv2')
#instances1 = client1.describe_load_balancers()
#elb_dns = instances1.get('LoadBalancers')[0].get('LoadBalancerArn').get('DNSName')

