#Create VPC in us-east-1
resource "aws_vpc" "virginia-vpc" {
  provider             = aws.virginia
  cidr_block           = "200.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "virginia-vpc"
  }

}

#Create VPC in us-east-2
resource "aws_vpc" "ohio-vpc" {
  provider             = aws.ohio
  cidr_block           = "201.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ohio-vpc"
  }

}

#Create IGW in us-east-1
resource "aws_internet_gateway" "igw-virginia" {
  provider = aws.virginia
  vpc_id   = aws_vpc.virginia-vpc.id
  tags = {
    Name = "igw-virginia"
  }
}

#Create IGW in us-east-2
resource "aws_internet_gateway" "igw-ohio" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio-vpc.id
  tags = {
    Name = "igw-ohio"
  }
}

#Get all available AZ's in VPC for virginia region
data "aws_availability_zones" "az-virginia" {
  provider = aws.virginia
  state    = "available"
}

#Get  all AZ's in VPC for ohio region
data "aws_availability_zones" "az-ohio" {
  provider = aws.ohio
  state    = "available"
}

#Create subnet # a in us-east-1
resource "aws_subnet" "subnet_1" {
  provider          = aws.virginia
  availability_zone = element(data.aws_availability_zones.az-virginia.names, 0)
  vpc_id            = aws_vpc.virginia-vpc.id
  cidr_block        = "200.0.0.0/28"
  tags = {
    Name = "net-virginia-1a"
  }
}


#Create subnet # b  in us-east-1
resource "aws_subnet" "subnet_2" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.virginia-vpc.id
  availability_zone = element(data.aws_availability_zones.az-virginia.names, 1)
  cidr_block        = "200.0.0.16/28"
  tags = {
    Name = "net-virginia-1b"
  }
}


#Create subnet in us-east-2a
resource "aws_subnet" "subnet_1-ohio" {
  provider          = aws.ohio
  vpc_id            = aws_vpc.ohio-vpc.id
  availability_zone = element(data.aws_availability_zones.az-ohio.names, 0)
  cidr_block        = "201.0.0.0/28"
  tags = {
    Name = "net-ohio-a"
  }
}

#################################################################################################################################

#Initiate Peering connection request from us-east-1
resource "aws_vpc_peering_connection" "virginia-ohio" {
  provider    = aws.virginia
  peer_vpc_id = aws_vpc.ohio-vpc.id
  vpc_id      = aws_vpc.virginia-vpc.id
  peer_region = var.ohio
  tags = {
    Name = "virginia-ohio-peering"
  }

}

#Accept VPC peering request in us-east-2 from us-east-1
resource "aws_vpc_peering_connection_accepter" "accept_peering-ohio-virginia" {
  provider                  = aws.ohio
  vpc_peering_connection_id = aws_vpc_peering_connection.virginia-ohio.id
  auto_accept               = true
  tags = {
    Name = "ohio-virginia-peering"
  }
}

#Create route table in us-east-1
resource "aws_route_table" "internet_route-virginia" {
  provider = aws.virginia
  vpc_id   = aws_vpc.virginia-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-virginia.id
  }
  route {
    cidr_block                = "201.0.0.0/28"
    vpc_peering_connection_id = aws_vpc_peering_connection.virginia-ohio.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "virginia-rt"
  }
}

#Create route table in us-east-2
resource "aws_route_table" "internet_route_ohio" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-ohio.id
  }
  route {
    cidr_block                = "200.0.0.0/28"
    vpc_peering_connection_id = aws_vpc_peering_connection.virginia-ohio.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "ohio-rt"
  }
}

resource "aws_route_table_association" "virginia-subnet-a" {
  provider       = aws.virginia
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.internet_route-virginia.id
}

resource "aws_route_table_association" "ohio-subnet-c" {
  provider       = aws.ohio
  subnet_id      = aws_subnet.subnet_1-ohio.id
  route_table_id = aws_route_table.internet_route_ohio.id
}