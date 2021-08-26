#Creates SG for Cis2
resource "aws_security_group" "cis2-sg" {
  provider    = aws.virginia
  name        = "cis2-sg"
  description = "Allows ssh from internet"
  vpc_id      = aws_vpc.test-vpc.id
  ingress {
    description = "Allows SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allows all out to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "cis2-sg"
  }
}