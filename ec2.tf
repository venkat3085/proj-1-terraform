# Data source for latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 instance for ML workloads
resource "aws_instance" "ml_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.ml_sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  iam_instance_profile   = aws_iam_instance_profile.ml_instance_profile.name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3 python3-pip
    pip3 install boto3 pandas numpy scikit-learn flask
    
    # Create ML directories
    mkdir -p /home/ec2-user/ml-models
    mkdir -p /home/ec2-user/ml-data
    chown -R ec2-user:ec2-user /home/ec2-user/ml-*
  EOF

  tags = {
    Name        = "${var.project_name}-ml-instance"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "ML Workloads"
  }
}
