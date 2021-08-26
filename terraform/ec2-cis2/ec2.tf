provider "aws" {
  region = var.virginia
}

resource "aws_instance" "cis2-inst" {
  count                                = 1
  ami                                  = var.aws-cis2-ami
  instance_type                        = "t3.micro"
  key_name                             = aws_key_pair.key-cis2.key_name
  vpc_security_group_ids               = [aws_security_group.cis2-sg.id]
  subnet_id                            = aws_subnet.test-net.id
  associate_public_ip_address          = "1"
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
    Name = join("_", ["aws-cis2", count.index + 1])
  }

  volume_tags = {
    Name = join("_", ["aws-cis2-vol", count.index + 1])
  }

  depends_on = [aws_subnet.test-net, aws_key_pair.key-cis2]

}
