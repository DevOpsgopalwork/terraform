# Define the provider (AWS in this case)
provider "aws" {
  region = var.location # Change this to your desired region
}

# Create the VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Mainvpc"
  }
}

# Create the first public subnet
resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetA"
  }
}

# Create the second public subnet
resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetB"
  }
}

# Create the first private subnet
resource "aws_subnet" "subnet_c" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "PrivateSubnetA"
  }
}

# Create the second private subnet
resource "aws_subnet" "subnet_d" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "PrivateSubnetB"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
}

# Create a NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_a.id
}

# Create Elastic IPs for the NAT gateway
resource "aws_eip" "nat_eip" {
}

# Create separate route tables for public and private subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public_subnet_association_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate private route table with private subnets
resource "aws_route_table_association" "private_subnet_association_c" {
  subnet_id      = aws_subnet.subnet_c.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_d" {
  subnet_id      = aws_subnet.subnet_d.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create routes for public route table
resource "aws_route" "public_subnet" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

# Create routes for private route table to use the NAT gateway
resource "aws_route" "private_subnet" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

module "sgs" {
  source = "/home/rapidadmin/new/projectbase/sg"
  vpc_id = aws_vpc.main_vpc.id
}

module "eks" {
  source = "/home/rapidadmin/new/projectbase/EKS"
  sg_ids = module.sgs.security_group_public
  vpc_id = aws_vpc.main_vpc.id
  subnet_ids = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id,
    aws_subnet.subnet_c.id,
    aws_subnet.subnet_d.id,
  ]
  private_subnet_ids = [
    aws_subnet.subnet_c.id,
    aws_subnet.subnet_d.id,
  ]
}