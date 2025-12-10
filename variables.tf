variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project"
  type = string
  default = "ml-infra"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type = string
  default = "dev"
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
  default     = "ml-keypair"
}

variable "billing_threshold" {
  description = "Billing threshold in USD for alerts"
  type        = number
  default     = 10
}

variable "alert_email" {
  description = "Email address for billing alerts"
  type        = string
  default     = "admin@example.com"
}
