variable "name" {
  type = string
  description = "(Required) Name of the Fargate task"
}

variable "fargate_cpu" {
  type = number
  default = 256
  description = "(Optional) CPU value for the Fargate task"
}

variable "fargate_memory" {
  type = number
  default = 512
  description = "(Optional) Memory value for the Fargate task"
}

variable "ecs_cluster_id" {
  type = string
  description = "Docker image ECR arn"
}

variable "ecs_image_arn" {
  type = string
  description = "Docker image ECR arn"
}

variable "app_count" {
  type = number
  default = 1
}

variable "schedule" {
  type = string
  description = "(Required) CRON schedule expression to trigger the Fargate task"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "execution_policy" {
  type = string
  description = "(Required) Execution policy JSON"
}

variable "task_policy" {
  type = string
  description = "(Required) Execution policy JSON"
}


variable "logs_retention_days" {
  type = number
  description = "(Optional) number of days to retain the logs"
  default = 30
}

variable "region" {
  type = string
  description = "(Optional) AWS Region"
  default = "eu-west-1"
}

variable "stages" {
  type = string
  description = "(Required) Stages tag that corresponds to VPC"
}