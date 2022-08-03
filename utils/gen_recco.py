import json
import getopt, sys
import uuid
import traceback


argumentList = sys.argv[1:]

def generate_volume_reco(region, account, resource_id, resource_name):
    return {
        "id": str(uuid.uuid4()),
        "region": region,
        "primaryImpactedNodeId": resource_id,
        "otherImpactedNodeIds": [],
        "resourceId": resource_id,
        "resourceName": resource_name,
        "difficulty": 1,
        "risk": 1,
        "applicationEnvironment": "staging",
        "annualSavings": 33.15,
        "annualCost": 419.51,
        "status": "Manual Approval",
        "parameters": {},
        "templateApproved": False,
        "customerId": 5,
        "accountId": "631108317415",
        "accountNickname": "cloudfixtf-linter-demo",
        "opportunityType": "Gp2Gp3",
        "opportunityDescription": "EBS GP2 to Gp3",
        "generatedDate": "2022-06-20T07:01:17.274Z",
        "lastUpdatedDate": "2022-06-20T07:01:17.274Z"
    }

def generate_intel_to_amd_reco(region, account, resource_id, resource_name):
    return {
        "id": str(uuid.uuid4()),
        "region": region,
        "primaryImpactedNodeId": resource_id,
        "otherImpactedNodeIds": [],
        "resourceId": resource_id,
        "resourceName": resource_name,
        "difficulty": 1,
        "risk": 1,
        "applicationEnvironment": "staging",
        "annualSavings": 57.31,
        "annualCost": 596.00,
        "status": "Manual Approval",
        "parameters": {
            "Migrating to instance type": "t3a.micro",
            "Has recent snapshot": True
        },
        "templateApproved": True,
        "customerId": 5,
        "accountId": account,
        "accountNickname": "cloudfixtf-linter-demo",
        "opportunityType": "Ec2IntelToAmd",
        "opportunityDescription": "EC2 Intel to AMD",
        "generatedDate": "2022-05-06T12:10:11.568Z",
        "lastUpdatedDate": "2022-06-20T07:01:21.847Z"
    }

def generate_s3_reco(region, account, resource_id, resource_name):
    return {
        "id": str(uuid.uuid4()),
        "region": region,
        "primaryImpactedNodeId": resource_id,
        "otherImpactedNodeIds": [],
        "resourceId": resource_id,
        "resourceName": resource_name,
        "difficulty": 1,
        "risk": 1,
        "applicationEnvironment": "staging",
        "annualSavings": 33.15,
        "annualCost": 419.51,
        "status": "Manual Approval",
        "parameters": {},
        "templateApproved": False,
        "customerId": 5,
        "accountId": account,
        "accountNickname": "cloudfixtf-linter-demo",
        "opportunityType": "StandardToSIT",
        "opportunityDescription": "Intelligent Tiering for S3",
        "generatedDate": "2022-06-20T07:01:17.274Z",
        "lastUpdatedDate": "2022-06-20T07:01:17.274Z"
    }

def generate_efs_ia_reco(region, account, resource_id, resource_name):
    return {
        "id": str(uuid.uuid4()),
        "region": region,
        "primaryImpactedNodeId": resource_id,
        "otherImpactedNodeIds": [],
        "resourceId": resource_id,
        "resourceName": resource_name,
        "difficulty": 1,
        "risk": 1,
        "applicationEnvironment": "staging",
        "annualSavings": 33.15,
        "annualCost": 419.51,
        "status": "Manual Approval",
        "parameters": {},
        "templateApproved": False,
        "customerId": 5,
        "accountId": account,
        "accountNickname": "cloudfixtf-linter-demo",
        "opportunityType": "EfsInfrequentAccess",
        "opportunityDescription": "Intelligent Tiering for EFS",
        "generatedDate": "2022-06-20T07:01:17.274Z",
        "lastUpdatedDate": "2022-06-20T07:01:17.274Z"
    }

def generate_recos(item):
    if item['type'] == 'aws_ebs_volume':
        return generate_volume_reco(region, account_id, item['values']['id'], item['name'])

    if item['type'] == 'aws_instance':
        return generate_intel_to_amd_reco(region, account_id, item['values']['id'], item['name'])

    if item['type'] == 'aws_s3_bucket':
        return generate_s3_reco(region, account_id, item['values']['bucket'], item['values']['bucket'])

    if item['type'] == 'aws_efs_file_system':
        return generate_efs_ia_reco(region, account_id, item['values']['id'], item['name'])

try:
    tf = open(sys.argv[1])
    data = json.load(tf)
    arn = data['values']['root_module']['resources'][0]['values']['arn']
    
    account_id = arn.split(":")[4]
    region = arn.split(":")[3]
    recos = []
    
    for item in data['values']['root_module']['resources']:
        recos.append(generate_recos(item))
    for module in data['values']['root_module']['child_modules']:
        for item in module['resources']:        
            recos.append(generate_recos(item))
    print(json.dumps(recos, indent = 4))
except Exception as e:
    traceback.print_exc()
    
    
    