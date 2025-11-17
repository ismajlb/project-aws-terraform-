resource "aws_launch_template" "app_lt" {
  name_prefix            = "app-lt"
  image_id               = var.ami_id
  instance_type          = "t3.micro"
  key_name               = "mali-key"
  vpc_security_group_ids = var.security_group_ids


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "asg-app-instance"
      Project = "Test Project"
    }
  }
}
