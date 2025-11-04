#This is the output file for my company ec2 module

output "aws_instance_id1" {
  value = aws_instance.Web-1.id
}

output "aws_instance_id2" {
  value = aws_instance.Web-2.id
}

output "public_ip1" {
  value = aws_instance.Web-1.public_ip
}

output "public_ip2" {
  value = aws_instance.Web-2.public_ip
}

