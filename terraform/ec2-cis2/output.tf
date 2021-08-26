output "Cis2-Public-IPs" {
  value = {
    for instance in aws_instance.cis2-inst :
    instance.id => instance.public_ip
  }
}