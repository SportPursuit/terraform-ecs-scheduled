#####################################################
# Fargate task task role + policy
#####################################################

resource "aws_iam_role" "task_role" {
  name               = "${var.name}-task-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

# rendered policies
# iam_policy for lambda to access Elasticache
resource "aws_iam_policy" "task_policy" {
  name   = "${var.name}-task-policy"
  policy = var.task_policy
}

resource "aws_iam_role_policy_attachment" "task_policy" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_policy.arn
}

resource "aws_iam_role_policy_attachment" "readonly_ecr" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

