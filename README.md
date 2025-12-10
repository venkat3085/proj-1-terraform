# AWS ML Infrastructure with Terraform

A complete Infrastructure as Code (IaC) solution that automatically creates and manages AWS cloud resources for Machine Learning workloads using Terraform.

## 🚀 What This Project Does

This project automatically sets up a complete cloud infrastructure on AWS that includes:
- **Secure networking** with public and private subnets
- **Cloud storage** for ML models and data
- **Compute resources** with pre-installed ML libraries
- **Security controls** and access management
- **Cost monitoring** and billing alerts

## 🏗️ Infrastructure Overview

### What Gets Created (23 AWS Resources)

**Networking (7 resources):**
- Virtual Private Cloud (VPC) - Your own private network in the cloud
- Internet Gateway - Allows internet access
- 2 Subnets - Public (internet-facing) and Private (internal only)
- Security Group - Firewall rules for your servers
- Route Table + Association - Traffic routing configuration

**Compute (2 resources):**
- EC2 Instance - Virtual server with ML libraries pre-installed
- AMI Data Source - Amazon Linux operating system image

**Storage (6 resources):**
- 3 S3 Buckets - Cloud storage for ML data, models, and Terraform state
- 3 Public Access Blocks - Security settings to prevent accidental exposure
- Versioning - Keeps backup copies of your files

**Security & Access (4 resources):**
- IAM Role - Secure identity for the server
- IAM Policy - Permissions for accessing storage
- IAM Role Attachment - Connects permissions to the role
- Instance Profile - Applies the role to the server

**Monitoring (3 resources):**
- CloudWatch Billing Alarm - Alerts when costs exceed $10
- SNS Topic - Notification system
- Email Subscription - Sends alerts to your email

**Utilities (2 resources):**
- Random ID Generator - Creates unique names
- DynamoDB Table - Prevents multiple people from changing infrastructure simultaneously (state locking)

## 📋 Prerequisites

Before you can use this project, you need:

1. **AWS Account** - Sign up at [aws.amazon.com](https://aws.amazon.com)
2. **AWS CLI** - Command line tool to interact with AWS
3. **Terraform** - Infrastructure automation tool
4. **SSH Key Pair** - For secure server access

## 🛠️ Quick Start

### 1. Clone and Setup
```bash
git clone <your-repo-url>
cd proj-1-terraform
```

### 2. Configure AWS Credentials
```bash
aws configure
# Enter your AWS Access Key ID, Secret Key, and region (us-east-1)
```

### 3. Create SSH Key Pair
```bash
aws ec2 create-key-pair --key-name ml-keypair --query 'KeyMaterial' --output text > ml-keypair.pem
chmod 400 ml-keypair.pem
```

### 4. Deploy Infrastructure
```bash
terraform init      # Download required plugins
terraform plan       # Preview what will be created
terraform apply      # Create the infrastructure (type 'yes' when prompted)
```

### 5. Connect to Your Server
```bash
ssh -i ml-keypair.pem ec2-user@<public-ip-from-output>
```

## 📁 Project Structure

```
proj-1-terraform/
├── main.tf                 # Main configuration and AWS provider
├── variables.tf            # Input parameters you can customize
├── outputs.tf              # Important information displayed after deployment
├── vpc.tf                  # Network setup (VPC, subnets, internet gateway)
├── security_groups.tf      # Firewall rules
├── s3.tf                   # Cloud storage buckets
├── iam.tf                  # Security roles and permissions
├── ec2.tf                  # Virtual server configuration
├── backend.tf              # Remote state storage setup
├── billing.tf              # Cost monitoring and alerts
├── terraform.tfvars.example # Template for your custom settings
└── modules/
    └── networking/         # Reusable network components
        ├── main.tf
        └── variables.tf
```

## 🔧 Customization

You can modify these settings in `terraform.tfvars`:

```hcl
project_name = "my-ml-project"    # Change project name
environment = "production"        # Change environment
vpc_cidr = "10.0.0.0/16"         # Change network range
aws_region = "us-west-2"         # Change AWS region
billing_threshold = 20           # Change cost alert threshold
```

## 🧪 Testing Your Infrastructure

After deployment, verify everything works:

```bash
# Test SSH connection
ssh -i ml-keypair.pem ec2-user@<your-server-ip> "echo 'Connected successfully!'"

# Test ML libraries
ssh -i ml-keypair.pem ec2-user@<your-server-ip> "python3 -c 'import boto3, pandas, numpy; print(\"ML libraries working!\")'"

# Test S3 access
ssh -i ml-keypair.pem ec2-user@<your-server-ip> "aws s3 ls s3://<your-data-bucket>/"
```

## 💰 Cost Management

This infrastructure is designed to be cost-effective:
- Uses `t3.micro` instances (eligible for AWS Free Tier)
- Automatic billing alerts when costs exceed $10/month
- All resources are tagged for easy cost tracking
- S3 buckets have public access blocked by default

**Estimated monthly cost:** $5-15 (depending on usage)

## 🔒 Security Features

- **Network Isolation:** Private subnets for sensitive resources
- **Firewall Rules:** Only necessary ports are open (SSH, HTTP, HTTPS)
- **IAM Roles:** Servers get temporary, limited permissions (no permanent keys)
- **Encrypted Storage:** S3 buckets use server-side encryption
- **Access Logging:** All API calls are logged by AWS CloudTrail

## 🚨 Troubleshooting

**Can't SSH to server?**
- Check security group allows SSH (port 22) from your IP
- Verify route table has internet gateway route
- Ensure key pair permissions: `chmod 400 ml-keypair.pem`

**Terraform errors?**
- Run `terraform init` to download plugins
- Check AWS credentials: `aws sts get-caller-identity`
- Verify region settings match your AWS CLI configuration

**High costs?**
- Check CloudWatch billing dashboard
- Review S3 storage usage
- Ensure you're not running large EC2 instances

## 🧹 Cleanup

To avoid ongoing charges, destroy the infrastructure when done:

```bash
terraform destroy  # Type 'yes' when prompted
```

**Note:** This will permanently delete all resources and data!

## 📚 What You'll Learn

By using this project, you'll gain hands-on experience with:

- **Infrastructure as Code (IaC)** - Managing infrastructure through code
- **AWS Cloud Services** - VPC, EC2, S3, IAM, CloudWatch
- **Terraform** - Industry-standard infrastructure automation
- **DevOps Practices** - Version control, automation, monitoring
- **Cloud Security** - IAM roles, security groups, network isolation
- **Cost Management** - Resource tagging, billing alerts, optimization

## 🎯 Next Steps

After mastering this infrastructure:

1. **Add monitoring** with Prometheus and Grafana
2. **Implement CI/CD** with GitHub Actions
3. **Container orchestration** with Kubernetes/EKS
4. **Multi-environment** setup (dev/staging/prod)
5. **Infrastructure testing** with Terratest

## 👨‍💻 Author

**Venkat** - [GitHub](https://github.com/venkat3085)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
