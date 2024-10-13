# tests/test_security_groups.py

import pytest
import boto3
from botocore.exceptions import ClientError

@pytest.mark.terraform("security_groups", directory="../modules/security_groups")
def test_security_groups_creation(tf_test):
    # Lấy outputs từ Terraform
    public_sg_id = tf_test.output("public_security_group_id")
    private_sg_id = tf_test.output("private_security_group_id")
    
    # Kiểm tra rằng Security Groups IDs không trống
    assert public_sg_id is not None, "Public Security Group ID should not be empty"
    assert private_sg_id is not None, "Private Security Group ID should not be empty"
    
    # Khởi tạo client EC2
    ec2_client = boto3.client('ec2', region_name='us-east-1')
    
    # Kiểm tra mô tả của Public Security Group
    try:
        response = ec2_client.describe_security_groups(GroupIds=[public_sg_id])
        public_sg = response['SecurityGroups'][0]
    except ClientError as e:
        pytest.fail(f"Failed to describe Public Security Group: {e}")
    
    assert public_sg['Description'] == "Security Group for Public EC2 instances", "Public SG description should match"
    
    # Kiểm tra mô tả của Private Security Group
    try:
        response = ec2_client.describe_security_groups(GroupIds=[private_sg_id])
        private_sg = response['SecurityGroups'][0]
    except ClientError as e:
        pytest.fail(f"Failed to describe Private Security Group: {e}")
    
    assert private_sg['Description'] == "Security Group for Private EC2 instances", "Private SG description should match"
    
    # Kiểm tra các quy tắc ingress của Public Security Group
    public_ingress_rules = public_sg['IpPermissions']
    assert len(public_ingress_rules) == 3, "Public SG should have 3 ingress rules"
    
    # Kiểm tra các quy tắc ingress của Private Security Group
    private_ingress_rules = private_sg['IpPermissions']
    assert len(private_ingress_rules) == 2, "Private SG should have 2 ingress rules"
