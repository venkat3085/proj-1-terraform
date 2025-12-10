# S3 bucket for ML models
resource "aws_s3_bucket" "ml_models" {
  bucket = "${var.project_name}-ml-models-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-ml-models"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "ML Models Storage"
  }
}

# S3 bucket for ML data
resource "aws_s3_bucket" "ml_data" {
  bucket = "${var.project_name}-ml-data-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-ml-data"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "ML Data Storage"
  }
}

# Random ID for unique bucket names
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Block public access for models bucket
resource "aws_s3_bucket_public_access_block" "ml_models_pab" {
  bucket = aws_s3_bucket.ml_models.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Block public access for data bucket
resource "aws_s3_bucket_public_access_block" "ml_data_pab" {
  bucket = aws_s3_bucket.ml_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
