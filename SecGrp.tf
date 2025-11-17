# Create a Security Group
resource "aws_security_group" "mali-sg" {
  name        = "mali-sg"
  vpc_id      = aws_vpc.second_vpc.id
  description = "mali-sg"
  tags = {
    Name = "mali-sg"
  }
}

# Allow ssh from any IP to port 22
resource "aws_vpc_security_group_ingress_rule" "sshfromyIP" {
  security_group_id = aws_security_group.mali-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Allow HTTP from any IP to port 80
resource "aws_vpc_security_group_ingress_rule" "allow_http" {

  security_group_id = aws_security_group.mali-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Allow HTTPS from any IP to port 443
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.mali-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Allow outbound connection with IPv4
resource "aws_vpc_security_group_egress_rule" "allowAllOutbound_ipv4" {
  security_group_id = aws_security_group.mali-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Allow outbound connection with IPv6
resource "aws_vpc_security_group_egress_rule" "allowAllOutbound_ipv6" {
  security_group_id = aws_security_group.mali-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
