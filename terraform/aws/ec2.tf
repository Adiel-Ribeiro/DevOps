provider "aws" {
  region = var.virginia
}

resource "aws_instance" "virginia-1a-inst" {
  ami                         = var.aws-ami-virginia
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.virginia-sg.id]
  subnet_id                   = aws_subnet.subnet_1.id
  associate_public_ip_address = "1"
  # iam_instance_profile                   =        "ecsInstanceRole" 
  # cpu_core_count                         =        "1" 
  cpu_threads_per_core                 = "2"
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = "0"
  monitoring                           = "1"
  tenancy                              = "default"

  root_block_device {
    volume_size           = "10"
    delete_on_termination = "true"
    encrypted             = "true"
    # kms_key_id                            = 
  }

  tags = {
    Name = "virginia-1a-inst"
  }

  volume_tags = {
    Name = "virginia-1a-vol"
  }

  availability_zone = var.virginia-aza

  key_name = "training"

}

resource "aws_instance" "virginia-1b-inst" {
  ami                         = var.aws-ami-virginia
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.virginia-1b-sg.id]
  subnet_id                   = aws_subnet.subnet_2.id
  associate_public_ip_address = "1"
  # iam_instance_profile                   =        "ecsInstanceRole" 
  # cpu_core_count                         =        "1" 
  cpu_threads_per_core                 = "2"
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = "0"
  monitoring                           = "1"
  tenancy                              = "default"

  root_block_device {
    volume_size           = "10"
    delete_on_termination = "true"
    encrypted             = "true"
    # kms_key_id                            = 
  }

  tags = {
    Name = "virginia-1b-inst"
  }

  volume_tags = {
    Name = "virginia-1b-vol"
  }

  availability_zone = var.virginia-azb

  key_name = "training"

}

resource "aws_instance" "ohio-1a-inst" {
  provider                    = aws.ohio
  ami                         = var.aws-ami-ohio
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.ohio-sg.id]
  subnet_id                   = aws_subnet.subnet_1-ohio.id
  associate_public_ip_address = "1"
  # iam_instance_profile                   =        "ecsInstanceRole" 
  # cpu_core_count                         =        "1" 
  cpu_threads_per_core                 = "2"
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = "0"
  monitoring                           = "1"
  tenancy                              = "default"

  root_block_device {
    volume_size           = "10"
    delete_on_termination = "true"
    encrypted             = "true"
    # kms_key_id                            = 
  }

  tags = {
    Name = "ohio-1a-inst"
  }

  volume_tags = {
    Name = "ohio-1a-vol"
  }

  availability_zone = var.ohio-aza

  key_name = "training-ohio"

}