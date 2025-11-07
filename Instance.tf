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

  ami_id            = data.aws_ami.amiID.id
  security_group_id = aws_security_group.mali-sg.id
  subnet_ids        = [aws_subnet.subnet-pub-1.id, aws_subnet.subnet-pub-2.id]
}


output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.compute.asg_name
}

output "asg_launch_template" {
  description = "Launch template used by ASG"
  value       = module.compute.asg_launch_template_id
}
