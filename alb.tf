resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.subnet-pub-1.id,
    aws_subnet.subnet-pub-2.id
  ]

  tags = {
    Name = "app-alb"
  }
}

resource "aws_lb_cookie_stickiness_policy" "stickcookies" {
  name                     = "test-policy"
  load_balancer            = aws_lb.app_alb.id
  lb_port                  = 80
  cookie_expiration_period = 600
}

# EC2 security group (mali-sg)
resource "aws_security_group_rule" "allow_http_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mali-sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

