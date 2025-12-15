resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.mali-sg.id]
  subnets = [
    aws_subnet.subnet-pub-1.id,
    aws_subnet.subnet-pub-2.id
  ]

  tags = {
    Name = "app-alb"
  }
}
