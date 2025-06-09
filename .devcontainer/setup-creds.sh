#!/bin/bash

echo "🔐 Starting credential setup..."

########################
# AWS Configuration
########################

if [[ -n "$AWS_ACCESS_KEY_ID" && -n "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "→ Configuring AWS CLI"
  mkdir -p ~/.aws

  cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

  cat <<EOF > ~/.aws/config
[default]
region = ${AWS_REGION:-us-east-1}
output = json
EOF

  echo "✅ AWS CLI configured"
else
  echo "⚠️  AWS credentials not found in environment"
fi

########################
# Azure Configuration
########################

if [[ -n "$AZURE_CLIENT_ID" && -n "$AZURE_CLIENT_SECRET" && -n "$AZURE_TENANT_ID" ]]; then
  echo "→ Logging into Azure using service principal"
  az login --service-principal \
    --username "$AZURE_CLIENT_ID" \
    --password "$AZURE_CLIENT_SECRET" \
    --tenant "$AZURE_TENANT_ID" \
    > /dev/null

  echo "✅ Azure CLI authenticated"
else
  echo "⚠️  Azure service principal credentials not found in environment"
fi

########################
# GCP Configuration
########################

if [[ -n "$GCP_CREDENTIALS_BASE64" ]]; then
  echo "→ Configuring GCP CLI"
  mkdir -p ~/.config/gcloud

  echo "$GCP_CREDENTIALS_BASE64" | base64 -d > ~/.config/gcloud/application_default_credentials.json

  gcloud auth activate-service-account --key-file ~/.config/gcloud/application_default_credentials.json \
    > /dev/null

  echo "✅ GCP CLI authenticated"
else
  echo "⚠️  GCP base64 credentials not found in environment"
fi

echo "✅ Credential setup complete!"