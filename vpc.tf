resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "mali_vpc"
  }

}

resource "aws_subnet" "mali-pub-1" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1
  tags = {
    Name = "mali-pub-1"
  }

}

resource "aws_subnet" "mali-pub-2" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2
  tags = {
    Name = "mali-pub-2"
  }

}

resource "aws_subnet" "mali-priv-1" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1
  tags = {
    Name = "mali-priv-1"
  }

}

resource "aws_subnet" "mali-priv-2" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2
  tags = {
    Name = "mali-priv-2"
  }

}


resource "aws_internet_gateway" "mali-IGW" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "mali-IGW"
  }
}

resource "aws_route_table" "mali-pub-RT" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mali-IGW.id
  }

  tags = {
    Name = "mali-pub-RT"
  }
}

resource "aws_route_table_association" "mali-pub-1-a" {
  subnet_id      = aws_subnet.mali-pub-1.id
  route_table_id = aws_route_table.mali-pub-RT.id

}

resource "aws_route_table_association" "mali-pub-2-a" {
  subnet_id      = aws_subnet.mali-pub-2.id
  route_table_id = aws_route_table.mali-pub-RT.id

}
