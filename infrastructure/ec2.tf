data "aws_ami" "default" {
  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
    # values = ["amzn2-ami-ecs-hvm-2.0.202*-x86_64-ebs"]
  }

  most_recent = true
  owners      = ["amazon"]
}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id                    = data.aws_ami.default.id
  iam_instance_profile        = aws_iam_instance_profile.ecs_agent.name
  security_groups             = [aws_security_group.ecs_sg.id]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${var.app_name}-${var.app_environment}-cluster >> /etc/ecs/ecs.config"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  name_prefix                 = "launch-configuration-${var.app_name}"
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                 = "auto-scaling-group"
  vpc_zone_identifier  = aws_subnet.public.*.id
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
}
