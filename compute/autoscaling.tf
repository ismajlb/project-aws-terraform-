resource "aws_autoscaling_group" "app_asg" {
  name                = "app-asg"
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = var.subnet_ids

  target_group_arns = var.target_group_arns
  health_check_type = "ELB"


  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Project"
    value               = "AutoScaling-App-instance"
    propagate_at_launch = true

  }
}
