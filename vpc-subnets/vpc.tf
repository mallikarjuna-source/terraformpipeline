provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private-subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_cidr)
  availability_zone = element(var.availability_zones, count.index)
  cidr_block        = element(var.private_cidr, count.index)


  tags = {
    Name = element(var.private_subnet_names, count.index)
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_eip" "my-eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "my-nat"
  }
}

resource "aws_route_table" "public-route-01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "public-route-01"
  }
}

resource "aws_route_table" "private-route-01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "private-route-01"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-01.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_cidr)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = aws_route_table.private-route-01.id
}