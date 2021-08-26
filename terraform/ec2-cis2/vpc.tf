#Create VPC in us-east-1
resource "aws_vpc" "test-vpc" {
  provider             = aws.virginia
  cidr_block           = "200.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-vpc"
  }

}

#Creates IGW in us-east-1
resource "aws_internet_gateway" "test-igw" {
  provider = aws.virginia
  vpc_id   = aws_vpc.test-vpc.id
  tags = {
    Name = "test-igw"
  }
}

#Get all available AZ's in VPC for virginia region
data "aws_availability_zones" "virginia-azs" {
  provider = aws.virginia
  state    = "available"
}

#Create subnet # a in us-east-1
resource "aws_subnet" "test-net" {
  provider          = aws.virginia
  availability_zone = element(data.aws_availability_zones.virginia-azs.names, 0)
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = "200.0.0.0/28"
  tags = {
    Name = "test-net-virginia-1a"
  }
}

#Create route table in us-east-1
resource "aws_route_table" "test-route" {
  provider = aws.virginia
  vpc_id   = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "test-rt"
  }
}

resource "aws_route_table_association" "test-rt" {
  provider       = aws.virginia
  subnet_id      = aws_subnet.test-net.id
  route_table_id = aws_route_table.test-route.id
}