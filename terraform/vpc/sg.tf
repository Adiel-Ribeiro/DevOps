#Creates SG for Virginia
resource "aws_security_group" "virginia-sg" {
  provider    = aws.virginia
  name        = "virginia-sg"
  description = "Allows ssh from internet"
  vpc_id      = aws_vpc.virginia-vpc.id
  ingress {
    description = "Allows SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "virginia-sg"
  }
}

#Creates SG for Ohio
resource "aws_security_group" "ohio-sg" {
  provider    = aws.ohio
  name        = "ohio-sg"
  description = "Allows all traffic"
  vpc_id      = aws_vpc.ohio-vpc.id
  ingress {
    description = "Allows all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ohio-sg"
  }
}

#Creates SG for Virginia 1b
resource "aws_security_group" "virginia-1b-sg" {
  provider    = aws.virginia
  name        = "virginia-1b-sg"
  description = "Allows inbound traffic from virginia 1a and all outbound"
  vpc_id      = aws_vpc.virginia-vpc.id
  ingress {
    description     = "Allows all traffic from Virginia 1a"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.virginia-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "virginia-1b-sg"
  }
}