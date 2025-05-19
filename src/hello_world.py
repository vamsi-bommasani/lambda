import json
import boto3
import os

def lambda_handler(event, context):
    sns_topic_arn = os.environ['SNS_TOPIC_ARN']
    sns = boto3.client('sns')
    
    message = "Hello World"
    
    response = sns.publish(
        TopicArn=sns_topic_arn,
        Message=message,
        Subject='Lambda Trigger Notification'
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Message sent to SNS topic: Hello World')
    }

# This is a simple AWS Lambda function that returns a "Hello, World!" message.