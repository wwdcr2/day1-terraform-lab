locals {
  public_subnet_map = {
    for index, az in var.availability_zones : az => {
      index             = index
      name              = "subnet-pub-${az}"
      availability_zone = "${var.region}${az}"
    }
  }
  instance_placement_az = element(var.availability_zones, 0)
}

# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

# Subnet
resource "aws_subnet" "publics" {
  for_each = local.public_subnet_map

  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true

  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, each.value.index)
  availability_zone = each.value.availability_zone

  tags = {
    "Name" = each.value.name
  }
}

# Route Table
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = local.resource_name
  }
}

resource "aws_route" "this_igw" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "this" {
  for_each = aws_subnet.publics

  subnet_id      = each.value.id
  route_table_id = aws_route_table.this.id
}

# Security Group
resource "aws_security_group" "ec2" {
  name   = local.resource_name
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
