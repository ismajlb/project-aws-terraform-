resource "aws_launch_template" "app_lt" {
  name_prefix            = "app-lt"
  image_id               = var.ami_id
  instance_type          = "t3.micro"
  key_name               = "mali-key"
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile {
    name = var.instance_profile_name
  }


  user_data = base64encode(file("${path.module}/../web.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "asg-app-instance"
      Project = "Test Project"
    }
  }
}
