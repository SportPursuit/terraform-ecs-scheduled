resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "${var.name}-schedule"
  description         = "${var.name}-schedule"
  schedule_expression = var.schedule
}

resource "aws_iam_role" "role" {
  name = "${var.name}-ecs-cluster-role"

  assume_role_policy = <<DOC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
DOC
}

resource "aws_iam_policy" "schedule_policy" {
  name = "${var.name}-ecs-cluster-policy"

  policy = <<DOC
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ecs:RunTask",
            "Resource": "${replace(aws_ecs_task_definition.definition.arn, "/:\\d+$/", ":*")}"
        }
    ]
}
DOC
}

resource "aws_iam_role_policy_attachment" "schedule_policy_attachement" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.schedule_policy.arn
}



resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  target_id = "${var.name}-run-scheduled-task"
  arn       = var.ecs_cluster_id
  rule      = aws_cloudwatch_event_rule.schedule.name
  role_arn  = aws_iam_role.role.arn

  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.definition.arn
    launch_type         = "FARGATE"
    platform_version    = "LATEST"

    network_configuration {
      assign_public_ip = false
      security_groups  = [aws_security_group.sg.id]
      subnets          = var.subnet_ids
    }
  }


}