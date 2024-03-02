provider "aws" {
  region = "sa-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "my-vpc"
   }
}

resource "aws_subnet" "public_sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "192.168.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-sub"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "192.168.16.0/24"

  tags = {
    Name = "private-sub"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route" "my_route" {
  route_table_id            = aws_vpc.my_vpc.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.my_igw.id
}

resource "aws_eip" "my_eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_sub.id

  tags = {
    Name = "my-nat"
  }
}

resource "aws_route_table" "private_route_t" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat.id
  }
}
resource "aws_route_table_association" "my_associat" {
  subnet_id      = aws_subnet.private_sub.id
  route_table_id = aws_route_table.private_route_t.id
}


resource "aws_instance" "demo_inst" {
  ami           = "your-nginx-ami"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_sub.id
  security_groups = [aws_security_group.my_security.id ]
  tags = {
    Name = "proxy-inst"
  }
}

resource "aws_instance" "demo_inst" {
  ami           = "your-app-ami"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_sub.id
  security_groups = [aws_security_group.my_security.id ]
  tags = {
    Name = "app-inst"
  }
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
