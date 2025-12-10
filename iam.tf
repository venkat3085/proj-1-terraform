# IAM role for ML EC2 instances
resource "aws_iam_role" "ml_ec2_role" {
  name = "${var.project_name}-ml-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ml-ec2-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

# IAM policy for S3 access
resource "aws_iam_policy" "ml_s3_policy" {
  name        = "${var.project_name}-ml-s3-policy"
  description = "Policy for ML workloads to access S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.ml_models.arn,
          "${aws_s3_bucket.ml_models.arn}/*",
          aws_s3_bucket.ml_data.arn,
          "${aws_s3_bucket.ml_data.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ml-s3-policy"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "ml_s3_attachment" {
  role       = aws_iam_role.ml_ec2_role.name
  policy_arn = aws_iam_policy.ml_s3_policy.arn
}

# Instance profile for EC2
resource "aws_iam_instance_profile" "ml_instance_profile" {
  name = "${var.project_name}-ml-instance-profile"
  role = aws_iam_role.ml_ec2_role.name

  tags = {
    Name        = "${var.project_name}-ml-instance-profile"
    Environment = var.environment
    Project     = var.project_name
  }
}
