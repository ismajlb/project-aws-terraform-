# compute/outputs.tf

output "asg_name" {
  value       = aws_autoscaling_group.app_asg.name
  description = "Name of the Auto Scaling Group"
}

output "asg_arn" {
  value       = aws_autoscaling_group.app_asg.arn
  description = "ARN of the Auto Scaling Group"
}

output "asg_launch_template_id" {
  value       = aws_launch_template.app_lt.id
  description = "Launch Template ID used by ASG"
}
