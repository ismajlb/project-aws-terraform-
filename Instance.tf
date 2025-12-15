data "aws_ami" "amiID" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "compute" {
  source = "./compute"

  ami_id             = data.aws_ami.amiID.id
  security_group_ids = [aws_security_group.mali-sg.id]
  subnet_ids = [
    aws_subnet.subnet-priv-1.id,
    aws_subnet.subnet-priv-2.id
  ]

  target_group_arns = [aws_lb_target_group.app_tg.arn]
}



output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.compute.asg_name
}

output "asg_launch_template" {
  description = "Launch template used by ASG"
  value       = module.compute.asg_launch_template_id
}
