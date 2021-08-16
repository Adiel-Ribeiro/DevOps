provider "aws" {
  region = var.virginia
}

resource "aws_instance" "cis2-inst" {
  ami                         = var.aws-cis2-ami
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [var.sg-training]
  subnet_id                   = var.subnet-training
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

  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = "true"
    encrypted             = "true"
    # kms_key_id                            =
  }

  tags = {
    Name = "aws-cis2-training"
  }

  volume_tags = {
    Name = "aws-cis2-training-vol"
  }

  provisioner "file" {
    source      = var.src-file
    destination = var.dst
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x var.dst",
      "var.dst",
      "rm var.dst",
    ]
  }

  availability_zone = var.virginia-aza

  key_name = "training"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.training-pem)
    host        = self.public_ip
    port        = var.ssh
  }

}
