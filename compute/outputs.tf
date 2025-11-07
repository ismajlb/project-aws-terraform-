# ASG name
output "asg_name" {
  value       = aws_autoscaling_group.asg.name
  description = "The name of the Auto Scaling Group"
}

# ASG ARN
output "asg_arn" {
  value       = aws_autoscaling_group.asg.arn
  description = "ARN of the Auto Scaling Group"
}

# Launch Template ID
output "launch_template_id" {
  value       = aws_launch_template.asg_lt.id
  description = "ID of the Launch Template used by ASG"
}

# List of current instance IDs in ASG
output "asg_instance_ids" {
  value       = aws_autoscaling_group.asg.instances
  description = "Current instances in the ASG"
}

# Optional: public IPs if instances are in public subnets
output "asg_public_ips" {
  value = [
    for id in aws_autoscaling_group.asg.instances :
    aws_instance.this[id].public_ip
  ]
  description = "Public IPs of ASG instances"
  depends_on  = [aws_autoscaling_group.asg]
}
