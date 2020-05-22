################################################################################
# CloudWatch Log Group
################################################################################

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/ecs/${var.name}-logs"
  retention_in_days = var.logs_retention_days
}