import boto3
from botocore.exceptions import ClientError
import json

def get_secret(secret_name, region_name):
    # Create a Secrets Manager client
    client = boto3.client('secretsmanager', region_name=region_name)

    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    except ClientError as e:
        print(f"Error retrieving secret: {e}")
        return None

    # Secrets Manager returns the secret either as a string or binary
    if 'SecretString' in get_secret_value_response:
        secret = get_secret_value_response['SecretString']
        # If the secret is JSON formatted, parse it (optional)
        try:
            secret_dict = json.loads(secret)
            return secret_dict
        except json.JSONDecodeError:
            return secret
    else:
        # Secret is binary, decode it
        secret = get_secret_value_response['SecretBinary']
        return secret

if __name__ == "__main__":
    secret_name = "apps/staging/api-tls-cert"
    region_name = "us-east-1"

    secret = get_secret(secret_name, region_name)
    if secret:
        print("Secret fetched successfully:")
        print(secret)
    else:
        print("Failed to fetch the secret.")
