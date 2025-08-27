output "public_instance_api" {
  value = [
    for instance in aws_instance.my-ec2 : instance.public_ip
  ]
}

output "private_instance_api" {
  value = [
    for instance in aws_instance.my-ec2 : instance.private_ip
  ]
}

output "public_instance_dns" {
  value = [
    for instance in aws_instance.my-ec2 : instance.public_dns
  ]
}