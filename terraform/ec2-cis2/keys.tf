resource "aws_key_pair" "key-cis2" {
  provider   = aws.virginia
  key_name   = "key-cis2"
  public_key = file(var.key-cis2)
}