# terraform-ecs-scheduled
Terraform module for Scheduled Fargate ECS

## Module Info
The module is built to initialize new Fargate tasks that can be scheduled using Cloudwatch Events.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_count | n/a | `number` | `1` | no |
| ecs\_cluster\_id | Docker image ECR arn | `string` | n/a | yes |
| ecs\_image\_arn | Docker image ECR arn | `string` | n/a | yes |
| execution\_policy | (Required) Execution policy JSON | `string` | n/a | yes |
| fargate\_cpu | (Optional) CPU value for the Fargate task | `number` | `256` | no |
| fargate\_memory | (Optional) Memory value for the Fargate task | `number` | `512` | no |
| logs\_retention\_days | (Optional) number of days to retain the logs | `number` | `30` | no |
| name | (Required) Name of the Fargate task | `string` | n/a | yes |
| region | (Optional) AWS Region | `string` | `"eu-west-1"` | no |
| schedule | (Required) CRON schedule expression to trigger the Fargate task | `string` | n/a | yes |
| stages | (Required) Stages tag that corresponds to VPC | `string` | n/a | yes |
| subnet\_ids | n/a | `list(string)` | n/a | yes |
| task\_policy | (Required) Execution policy JSON | `string` | n/a | yes |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->