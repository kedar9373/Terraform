provider "aws" {
  
  region     = "ap-northeast-1"
  access_key = "xxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxx"

}


resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
   tags = {
    Name = "main"
  }
 variable "cidr_block" {
  default = "10.0.0.0/16"
  }
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = " subnet for ap-northeast-1a"
  }              
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "example"
  }
}
