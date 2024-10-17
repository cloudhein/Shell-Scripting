#!/bin/bash

#####################################################################################################
# Maintainer: Nanda Hein
# Version: 1.0

# This script is used to automate the process of listing all the resources in an AWS account
# 
# Services supported by this script:
# 1. EC2
# 2. EBS
# 3. S3
# 4. RDS
# 5. Dynamodb
# 6. VPC
# 7. Cloudfront
# 8. IAM User & IAM Roles
# 9. Route53
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. Cloudformation
# 14. Cloudwatch
# 15. ECS
# 16. EKS
#
# The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_check_list.sh  <aws_region> <aws_service> <profile_name>
# Example: ./aws_resource_check_list.sh us-east-1 ec2 cloudadmin

#####################################################################################################

# Check if the required arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <aws_region> <aws_service> <profile_name>"
    echo "Example: ./aws_resource_check_list.sh us-east-1 ec2 cloudadmin"
    exit 1
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2
profile_name=$3

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install AWS CLI and try again."
    exit 1
fi

# Check if the AWS credentials are configured
if [ ! -d ~/.aws ]; then
    echo "AWS credentails is not configured. Please make sure to configure AWS credentials and try again."
    exit 1
fi 

# Check if the AWS region is valid
# if ! aws ec2 describe-regions --region $aws_region &> /dev/null; then
#     echo "Invalid AWS region: $aws_region"
#     exit 1
# fi

# List the resources based on the provided service
case $aws_service in

    ec2)
        echo "Listing EC2 instances in $aws_region region:"
        aws ec2 describe-instances --region $aws_region --profile $profile_name
        ;;

    ebs)
        echo "Listing EBS volumes in $aws_region region:"
        aws ec2 describe-volumes --region $aws_region --profile $profile_name
        ;;

    s3)
        echo "Listing S3 buckets in $aws_region region:"
        aws s3api list-buckets --region $aws_region --profile $profile_name
        ;;

    rds)
        echo "Listing RDS instances in $aws_region region:"
        aws rds describe-db-instances --region $aws_region --profile $profile_name
        ;;

    dynamodb)
        echo "Listing DynamoDB tables in $aws_region region:"
        aws dynamodb list-tables --region $aws_region --profile $profile_name
        ;;

    vpc)
        echo "Listing VPCs in $aws_region region:"
        aws ec2 describe-vpcs --region $aws_region --profile $profile_name
        ;;

    cloudfront)
        echo "Listing CloudFront distributions in $aws_region region:"
        aws cloudfront list-distributions --region $aws_region --profile $profile_name
        ;;

    iam-user)
        echo "Listing IAM users in $aws_region region:"
        aws iam list-users --region $aws_region --profile $profile_name
        ;;

    iam-role)
        echo "Listing IAM roles in $aws_region region:"
        aws iam list-roles --region $aws_region --profile $profile_name
        ;;

    route53)
        echo "Listing Route53 hosted zones in $aws_region region:"
        aws route53 list-hosted-zones --region $aws_region --profile $profile_name
        ;;
    
    lambda)
        echo "Listing Lambda functions in $aws_region region:"
        aws lambda list-functions --region $aws_region --profile $profile_name
        ;;

    sns)
        echo "Listing SNS topics in $aws_region region:"
        aws sns list-topics --region $aws_region --profile $profile_name
        ;;

    sqs)
        echo "Listing SQS queues in $aws_region region:"
        aws sqs list-queues --region $aws_region --profile $profile_name
        ;;

    cloudformation)
        echo "Listing CloudFormation stacks in $aws_region region:"
        aws cloudformation describe-stacks --region $aws_region --profile $profile_name
        ;;

    cloudwatch)
        echo "Listing CloudWatch alarms in $aws_region region:"
        aws cloudwatch describe-alarms --region $aws_region --profile $profile_name
        ;;

    ecs)
        echo "Listing ECS clusters in $aws_region region:"
        aws ecs list-clusters --region $aws_region --profile $profile_name
        ;;

    eks)
        echo "Listing EKS clusters in $aws_region region:"
        aws eks list-clusters --region $aws_region --profile $profile_name
        exit 1
        ;;

    *)
        echo "Invalid AWS service. Pease enter a valid AWS service."
        exit 1
        ;;
    esac