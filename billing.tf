# CloudWatch billing alarm
resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "${var.project_name}-billing-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"
  statistic           = "Maximum"
  threshold           = var.billing_threshold
  alarm_description   = "This metric monitors estimated charges"
  alarm_actions       = [aws_sns_topic.billing_alerts.arn]

  dimensions = {
    Currency = "USD"
  }

  tags = {
    Name        = "${var.project_name}-billing-alarm"
    Environment = var.environment
    Project     = var.project_name
  }
}

# SNS topic for billing alerts
resource "aws_sns_topic" "billing_alerts" {
  name = "${var.project_name}-billing-alerts"

  tags = {
    Name        = "${var.project_name}-billing-alerts"
    Environment = var.environment
    Project     = var.project_name
  }
}

# SNS topic subscription (email)
resource "aws_sns_topic_subscription" "billing_email" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
