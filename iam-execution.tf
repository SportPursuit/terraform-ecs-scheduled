resource "aws_iam_role" "execution_role" {
  name               = "${var.name}-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["s3.amazonaws.com", "ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

# rendered policies
# iam_policy for lambda to access Elasticache
resource "aws_iam_policy" "execution_policy" {
  name = "${var.name}-execution-policy"
  policy = var.execution_policy
}

resource "aws_iam_role_policy_attachment" "execution_policy" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.execution_policy.arn
}

//resource "aws_iam_role_policy_attachment" "readonly_ecr" {
//  role       = aws_iam_role.role.name
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
//}
//
