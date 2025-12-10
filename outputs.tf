# VPC outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.ml_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

# EC2 outputs
output "instance_id" {
  description = "ID of the ML instance"
  value       = aws_instance.ml_instance.id
}

output "instance_public_ip" {
  description = "Public IP of the ML instance"
  value       = aws_instance.ml_instance.public_ip
}

# S3 outputs
output "ml_models_bucket" {
  description = "Name of the ML models S3 bucket"
  value       = aws_s3_bucket.ml_models.bucket
}

output "ml_data_bucket" {
  description = "Name of the ML data S3 bucket"
  value       = aws_s3_bucket.ml_data.bucket
}

# IAM outputs
output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.ml_instance_profile.name
}
