# Create the main VPC
resource "aws_vpc" "second_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "mali_vpc"
  }

}

# Create first public subnet in Zone 1
resource "aws_subnet" "subnet-pub-1" {
  vpc_id                  = aws_vpc.second_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1
  tags = {
    Name = "subnet-pub-1"
  }

}

# Create second public subnet in Zone 2
resource "aws_subnet" "subnet-pub-2" {
  vpc_id                  = aws_vpc.second_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2
  tags = {
    Name = "subnet-pub-2"
  }

}

# Create first private subnet in Zone 1
resource "aws_subnet" "subnet-priv-1" {
  vpc_id                  = aws_vpc.second_vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.zone1
  tags = {
    Name = "subnet-priv-1"
  }

}
# Create second private subnet in Zone 2 (will use NAT Gateway)
resource "aws_subnet" "subnet-priv-2" {
  vpc_id                  = aws_vpc.second_vpc.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.zone2
  tags = {
    Name = "subnet-priv-2"
  }

}

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.main-IGW]
  domain     = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway in Public Subnet 2
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet-pub-2.id

  tags = {
    Name = "gw NAT"
  }

}

# Create Internet Gateway for public internet access
resource "aws_internet_gateway" "main-IGW" {
  vpc_id = aws_vpc.second_vpc.id
  tags = {
    Name = "main-IGW"
  }
}

# Create public route table and add route to Internet Gateway
resource "aws_route_table" "mali-pub-RT" {
  vpc_id = aws_vpc.second_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-IGW.id
  }

  tags = {
    Name = "mali-pub-RT"
  }
}
# Associate subnet-pub-1 with public route table
resource "aws_route_table_association" "subnet-pub-1-a" {
  subnet_id      = aws_subnet.subnet-pub-1.id
  route_table_id = aws_route_table.mali-pub-RT.id

}

# Associate subnet-pub-2 with public route table
resource "aws_route_table_association" "subnet-pub-2-a" {
  subnet_id      = aws_subnet.subnet-pub-2.id
  route_table_id = aws_route_table.mali-pub-RT.id

}

# Create private route table for subnet-priv-2 that routes via NAT Gateway
resource "aws_route_table" "mali-priv-2-RT" {
  vpc_id = aws_vpc.second_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "priv-2-nat-RT"
  }
}

# Associate ONLY subnet-priv-2 with NAT route
resource "aws_route_table_association" "subnet-priv-2-a" {
  subnet_id      = aws_subnet.subnet-priv-2.id
  route_table_id = aws_route_table.mali-priv-2-RT.id

}
