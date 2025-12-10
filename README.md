# AWS Infrastructure with Terraform

Automatically creates AWS cloud infrastructure for Machine Learning workloads using Infrastructure as Code (Terraform).

## What This Creates

- **Virtual Private Cloud (VPC)** - Secure network with public/private subnets
- **EC2 Instance** - Server with ML libraries (Python, boto3, pandas, numpy, sklearn)
- **S3 Buckets** - Storage for ML data, models, and Terraform state
- **Security** - IAM roles, security groups, encrypted storage
- **Monitoring** - Cost alerts when spending exceeds $10/month

**Total: 23 AWS resources deployed automatically**

## Quick Start

### Prerequisites
- AWS Account
- AWS CLI installed and configured
- Terraform installed

### Deploy
```bash
# 1. Clone repository
git clone https://github.com/venkat3085/proj-1-terraform.git
cd proj-1-terraform

# 2. Create SSH key
aws ec2 create-key-pair --key-name ml-keypair --query 'KeyMaterial' --output text > ml-keypair.pem
chmod 400 ml-keypair.pem

# 3. Deploy infrastructure
terraform init
terraform plan
terraform apply

# 4. Connect to server
ssh -i ml-keypair.pem ec2-user@<public-ip-from-output>
```

## Project Files

```
proj-1-terraform/
├── main.tf                 # AWS provider configuration
├── variables.tf            # Customizable settings
├── outputs.tf              # Important info after deployment
├── vpc.tf                  # Network setup
├── security_groups.tf      # Firewall rules
├── s3.tf                   # Storage buckets
├── iam.tf                  # Security permissions
├── ec2.tf                  # Server configuration
├── backend.tf              # Remote state storage
├── billing.tf              # Cost monitoring
└── terraform.tfvars.example # Configuration template
```

## Testing Your Setup

```bash
# Test SSH connection
ssh -i ml-keypair.pem ec2-user@<your-server-ip>

# Test ML libraries
python3 -c "import boto3, pandas, numpy; print('ML libraries working!')"

# Test S3 access
aws s3 ls s3://<your-data-bucket>/
```

## Cost & Cleanup

**Monthly cost:** ~$5-15 (uses t3.micro instances)

**To delete everything:**
```bash
terraform destroy
```

## 👨‍💻 Author

**Venkat** - [GitHub](https://github.com/venkat3085)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
