#####################################################
# ECS Task Definition + setup with AWS Logs
#####################################################

resource "aws_ecs_task_definition" "definition" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  tags = {
    Name    = "${var.name} Definition"
    Stages  = var.stages
    Project = "DataOps"
  }

  container_definitions = <<DEFINITION
[
  {
    "image": "${aws_ecr_repository.repository.repository_url}:latest",
    "name": "app",
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "/ecs/${var.name}-logs",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
        }
    }
  }
]
DEFINITION
}

resource "aws_security_group" "sg" {
  name        = "${var.name}-ecs-tasks-sg"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.name}-sg"
    Stages  = var.stages
    Project = "DataOps"
  }
}

