#!/usr/bin/env python
import boto3
import os
os.environ['AWS_DEFAULT_REGION'] = 'eu-west-2'
os.environ['AWS_ACCESS_KEY_ID'] = ''
os.environ['AWS_SECRET_ACCESS_KEY'] = ''

elbList = boto3.client('elb')
bals = elbList.describe_load_balancers()
for elb in bals['LoadBalancerDescriptions']:
    print ('http://'+elb['DNSName']+':'+str(8080))

