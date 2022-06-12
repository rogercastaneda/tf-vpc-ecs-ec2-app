data "template_file" "env_vars" {
  template = file("env_vars.json")
}

data "aws_ecr_image" "app" {
  repository_name = var.app_name
  image_tag       = "latest"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_name}-${var.app_environment}-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
}

# https://stackoverflow.com/a/53952794
resource "aws_ecs_task_definition" "web" {

  family = "${var.app_name}-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.app_name}-${var.app_environment}-container",
      "image": "${data.aws_ecr_repository.app.repository_url}:latest",
      "entryPoint": [],
      "environment": ${data.template_file.env_vars.rendered},
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "${var.app_name}-${var.app_environment}"
        }
      },
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "cpu": 256
    }
  ]
  DEFINITION

  memory = 256
  tags = {
    Name        = "${var.app_name}-ecs-td"
    Environment = var.app_environment
  }
}

resource "aws_ecs_service" "web" {
  name                               = "${var.app_name}-${var.app_environment}-ecs-service"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.web.arn
  desired_count                      = 1
  force_new_deployment               = true
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200
  # enable_ecs_managed_tags = true

  load_balancer {
    target_group_arn = aws_lb_target_group.web.arn
    container_name   = "${var.app_name}-${var.app_environment}-container"
    container_port   = 80
  }
}
