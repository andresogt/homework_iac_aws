resource "aws_vpc" "vpc_SOD" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

  tags = {
      "Name" = "VPC SOD"
    }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.vpc_SOD.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "public subnet 1 - SOD"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.vpc_SOD.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "public subnet 2 - SOD"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_SOD.id

  tags = {
    "Name" = "Internet Gateway para VPC"
  }

  depends_on = [
    aws_vpc.vpc_SOD
  ]
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_SOD.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "Public Route Table 1"
  }
}

resource "aws_route_table_association" "public_table_1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_table_2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "allow_http_ssh"
  vpc_id      = aws_vpc.vpc_SOD.id

  ingress {
    description      = "allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["181.135.45.209/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}