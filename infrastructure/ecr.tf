# ecr.tf | Elastic Container Repository

data "aws_ecr_repository" "app" {
  name = var.app_name
}
